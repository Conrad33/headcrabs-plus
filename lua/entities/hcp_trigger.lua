if CLIENT then return end

ENT.Type = "brush"
ENT.Base = "base_brush"
ENT.LastThink = 0

function ENT:Initialize()
	self:SetSolid(SOLID_BBOX)
	self:SetTrigger(true)
end