if CLIENT then return end
AccessorFunc(ENT, "m_Disabled", "Disabled", FORCE_BOOL)

ENT.Type = "brush"
ENT.Base = "base_brush"

function ENT:Initialize()
	self:SetSolid(SOLID_BBOX)
	self:SetTrigger(true)
	self.Ents = {}
end

function ENT.ShouldIgnore(ent)
	if not IsValid(ent) then return true end
	if ent:IsNPC() and not (HCP.Zombies[ent:GetClass()] or HCP.Headcrabs[ent:GetClass()]) then return false end
	return true
end

function ENT:CheckValid()
	if not IsValid(self.HCP_Entity) then
		self:SetDisabled(true)
		self:Remove()
		return true
	end
end

function ENT:Think()
	return true
end

function ENT:StartTouch(ent)
	if self:CheckValid() or self.ShouldIgnore(ent) then return end
	self.Ents[ent] = true
	if GetConVar("ai_disabled"):GetBool() or (ent:IsPlayer() and not GetConVar("ai_ignoreplayers"):GetBool()) then return end
	if self:GetDisabled() then return end
	self:CustomStartTouch(ent)
end

function ENT:EndTouch(ent)
	self.Ents[ent] = nil
	if self:CheckValid() or self:GetDisabled() or self.ShouldIgnore(ent) then return end
	if GetConVar("ai_disabled"):GetBool() or (ent:IsPlayer() and not GetConVar("ai_ignoreplayers"):GetBool()) then return end
	self:CustomEndTouch(ent)
end

function ENT:Touch(ent)
	if self:CheckValid() or self:GetDisabled() or self.ShouldIgnore(ent) or GetConVar("ai_disabled"):GetBool() then return end
	if GetConVar("ai_disabled"):GetBool() or (ent:IsPlayer() and not GetConVar("ai_ignoreplayers"):GetBool()) then return end
	self:CustomTouch(ent)
end

function ENT:CustomStartTouch()
end

function ENT:CustomEndTouch()
end

function ENT:CustomTouch()
end