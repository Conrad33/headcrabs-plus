function HCP.CalcPoisonBites(time)
	return math.max(math.ceil(((time or 0) - CurTime()) / HCP.GetConvarInt("poison_healtime")), 0)
end

function HCP.CalcPoisonBitesTime(bites)
	return CurTime() + HCP.GetConvarInt("poison_healtime") * bites
end

hook.Add("EntityTakeDamage", "HCP_PoisonBites", function(ent, dmg)
	local attacker = dmg:GetAttacker()

	print(dmg:IsDamageType(DMG_SLASH), dmg:IsDamageType(DMG_POISON), dmg:GetDamage(), ent:Health())

	if HCP.GetConvarInt("poison_bites") == 0 then return end
	if not HCP.CheckTakeOver(ent, nil, attacker) or attacker:GetClass() ~= "npc_headcrab_black" and attacker:GetClass() ~= "npc_headcrab_poison"  then return end

	if dmg:IsDamageType(DMG_POISON) then
		local bites = HCP.CalcPoisonBites(ent.HCP_PoisonBites) + 1
		if bites >= HCP.GetConvarInt("poison_bites") then
			dmg:SetDamage(9999)
			ent.HCP_PoisonBites = nil
			attacker.HCP_DMGLock = CurTime() + 0.1
			return
		end

		ent.HCP_PoisonBites = HCP.CalcPoisonBitesTime(bites)
		timer.Simple(0, function()
			if not IsValid(ent) then return end
			ent:SetHealth(2)
		end)
	else
		dmg:SetDamageType(DMG_GENERIC)
		dmg:SetDamage(0)
	end
end)