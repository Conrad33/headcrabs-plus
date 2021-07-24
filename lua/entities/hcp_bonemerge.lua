AddCSLuaFile()
ENT.Type = "anim"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "ShouldScale")
	self:NetworkVar("Bool", 1, "PlayerColorEnabled")
	self:NetworkVar("Vector", 0, "MockPlayerColor")
end

function ENT:Initialize()
	if SERVER then
		self:AddEffects(bit.bor(EF_BONEMERGE))
	end

	local parent = self:GetParent()
	if IsValid(parent) then
		if parent:GetModel() == "models/zombie.mdl" then
			parent:SetSubMaterial(10, "models/effects/vol_light001")
			for i = 12, 18 do
				parent:SetSubMaterial(i, "models/effects/vol_light001")
			end
		else
			parent:SetSubMaterial(0, "models/effects/vol_light001")
			parent:SetSkin(100)
		end
	end

	self:AddCallback("BuildBonePositions", self.BuildBonePositions)
end

function ENT:GetPlayerColor()
	if not self:GetPlayerColorEnabled() then return end
	return self:GetMockPlayerColor()
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:OnRemove()
	if IsValid(self:GetParent()) then
		self:GetParent():SetSubMaterial(0, "")
	end
end

function ENT:Resize(bone, vec, ang)
	local boneId = self:LookupBone(bone)
	local matrix = self:GetBoneMatrix(boneId or -1)
	if not boneId or not matrix then return end

	matrix:Scale(vec or Vector(.01, .01, .01))
	matrix:Rotate(ang or Angle(0, 0, 0))

	self:SetBoneMatrix(boneId, matrix)
end

function ENT:BuildBonePositions(boneCount)
	if not self:GetShouldScale() or not IsValid(self:GetParent()) then return end

	self:Resize("Bip01 Head")
	self:Resize("Bone05", Vector(0.5, 0.5, 0.5))

	if self:GetParent():GetModel() == "models/zombie/poison.mdl" then
		self:Resize("ValveBiped.Bip01_Head1", Vector(0.8, 0.8, 0.8), Angle(-90, 130, 0))
	else
		self:Resize("ValveBiped.Bip01_Head1")
	end
end