HCP.ZombieModels = {
	["npc_zombie"] = "models/zombie/classic.mdl",
	["npc_fastzombie"] = "models/zombie/fast.mdl",
	["npc_poisonzombie"] = "models/zombie/poison.mdl",
	["npc_zombine"] = "models/zombie/zombie_soldier.mdl",
}

HCP.ZombieHeadcrabModels = {
	["npc_zombie"] = "models/headcrabclassic.mdl",
	["npc_fastzombie"] = "models/headcrab.mdl",
	["npc_poisonzombie"] = "models/headcrabblack.mdl",
	["npc_zombine"] = "models/headcrabclassic.mdl",
}

-- Creates a configurable trigger and parents it to an Entity (returns Entity)
function HCP.CreateTrigger(size, entity)
	local trigger = ents.Create("hcp_trigger")
	trigger.HCP_Entity = entity
	trigger:Spawn()
	trigger:SetCollisionBounds(Vector(size / -2, size / -2, -64), Vector(size / 2, size / 2, 96))
	trigger:SetPos(entity:GetPos())
	trigger:SetParent(entity)
	entity:DeleteOnRemove(trigger)
	return trigger
end

-- Creates a Zombie Ragdoll from an Entity (returns Entity)
function HCP.CreateSleepingZombie(zclass, entity, nobonemerge)
	if not HCP.ZombieModels[zclass] then return false end

	local rag = ents.Create("prop_ragdoll")
	rag:SetModel(HCP.ZombieModels[zclass])
	rag:SetPos(entity:GetPos())
	rag:SetAngles(entity:GetAngles())
	rag:Spawn()
	rag:SetBodygroup(1, 1)
	rag.HCP_ZClass = zclass
	rag.HCP_YAngle = entity:GetAngles().y
	rag.HCP_Health = 50

	if not nobonemerge then
		HCP.CopyBonemerge(entity, rag)
	end

	for i = 14, rag:GetPhysicsObjectCount() do
		local physobj = rag:GetPhysicsObjectNum(i - 3)
		if IsValid(physobj) then
			local pos, ang = entity:GetBonePosition(entity:TranslatePhysBoneToBone(i - 3))
			physobj:SetPos(pos)
			physobj:SetAngles(ang)
			physobj:EnableMotion(true)
		end
	end

	rag.HCP_Trigger = HCP.CreateTrigger(math.max(400, HCP.GetConvarInt("sleeping_range")), rag)
	rag.HCP_Trigger.HCP_WakeTime = CurTime()
	function rag.HCP_Trigger:CustomTouch(ent)
		if self.HCP_WakeTime + HCP.GetConvarInt("sleeping_time") > CurTime() then return end

		self:SetDisabled(true)
		HCP.CreateWakingZombie(self.HCP_Entity)
		self:Remove()
	end

	return rag
end

local anims = {"slumprise_a", "slumprise_b", "slumprise_c"}
-- Creates a Waking Zombie from an Entity (returns Entity)
function HCP.CreateWakingZombie(entity, zclass)
	local zombie = HCP.CreateZombie(entity.HCP_ZClass or zclass or "npc_zombie", entity)
	if not IsValid(zombie) then return end

	local anim = table.Random(anims)
	if not table.HasValue(zombie:GetSequenceList(), anim) then anim = "slumprise_a" end

	local name = "hcp_zombie_" .. zombie:EntIndex()
	zombie.HCP_TTT = entity.HCP_TTT
	zombie.HCP_Script = ents.Create("scripted_sequence")
	zombie:SetName(name)
	zombie:SetKeyValue("spawnflags", "128")
	zombie:EmitSound("npc/barnacle/barnacle_crunch2.wav")
	zombie:DeleteOnRemove(zombie.HCP_Script)

	zombie.HCP_Script:SetKeyValue("m_iszEntity", name)
	zombie.HCP_Script:SetKeyValue("m_iszPlay", anim)
	zombie.HCP_Script:Fire("BeginSequence")
	SafeRemoveEntityDelayed(zombie.HCP_Script, 10)

	undo.ReplaceEntity(entity, zombie)
	entity:Remove()

	return zombie
end

-- Add the ability to kill sleeping zombies
hook.Add("EntityTakeDamage", "HCP_DamageRagdolls", function(ent, dmginfo)
	if ent.HCP_TTT or not ent.HCP_Health or not IsValid(dmginfo:GetAttacker()) or dmginfo:IsDamageType(DMG_CRUSH) then return end
	ent.HCP_Health = ent.HCP_Health - dmginfo:GetDamage()

	if ent.HCP_Health <= 0 then
		hook.Run("OnNPCKilled", ent, dmginfo:GetAttacker(), dmginfo:GetInflictor())

		if IsValid(ent.HCP_Trigger) then
			ent.HCP_Trigger.Disable = true
			ent.HCP_Trigger:Remove()
		end

		ent.HCP_Health = nil
		ent:EmitSound("npc/zombie/zombie_die1.wav")
		if not GetConVar("ai_serverragdolls"):GetBool() then
			ent:Fire("FadeAndRemove", "", 60)
			ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		end

		ent:SetBodygroup(1, 0)
		if IsValid(ent.HCP_Bonemerge) then ent.HCP_Bonemerge:SetShouldScale(false) end

		local attachment = ent:GetAttachment(ent:LookupAttachment("headcrab")) or {Pos = ent:GetPos(), Ang = ent:GetAngles()}
		local headcrab = ents.Create("prop_ragdoll")
		headcrab:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		headcrab:Fire("FadeAndRemove", "", 60)
		headcrab:SetPos(attachment.Pos)
		headcrab:SetAngles(attachment.Ang)
		headcrab:SetModel(HCP.ZombieHeadcrabModels[ent.HCP_ZClass or "npc_zombie"])
		headcrab:Spawn()
		headcrab:GetPhysicsObject():SetVelocity(Vector(0, 0, 300))
	end
end)