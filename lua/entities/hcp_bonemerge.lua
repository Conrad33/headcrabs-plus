AddCSLuaFile()
ENT.Type = "anim"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "ShouldScale")
	self:NetworkVar("Bool", 1, "Legs")
	self:NetworkVar("Vector", 0, "PlayerColor")
end

function ENT:Initialize()
	if SERVER then
		self:AddEffects(EF_BONEMERGE)
	end

	self:AddCallback("BuildBonePositions", self.BuildBonePositions)
end

function ENT:Draw()
	self:DrawModel()

	local parent = self:GetParent()
	if IsValid(parent) and not self:GetLegs() then
		if parent:GetModel() == "models/zombie.mdl" then
			parent:SetSubMaterial(10, "models/effects/vol_light001")
			for i = 12, 18 do
				parent:SetSubMaterial(i, "models/effects/vol_light001")
			end
		else
			parent:SetSubMaterial(0, "models/effects/vol_light001")
			parent:SetSkin(100)
		end
	elseif IsValid(parent) then
		parent:SetSubMaterial(0, "")
	end
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

function ENT:ResizeParent(bone, vec, ang)
	local parent = self:GetParent()
	local boneId = parent:LookupBone(bone)
	local matrix = parent:GetBoneMatrix(boneId or -1)
	if not boneId or not matrix then return end

	matrix:Scale(vec or Vector(.01, .01, .01))
	matrix:Rotate(ang or Angle(0, 0, 0))

	parent:SetBoneMatrix(boneId, matrix)
end


function ENT:BuildBonePositions(boneCount)
	if not self:GetShouldScale() or not IsValid(self:GetParent()) then return end

	if self:GetLegs() then
		self:ResizeParent("ValveBiped.Bip01_L_Thigh")
		self:ResizeParent("ValveBiped.Bip01_L_Calf")
		self:ResizeParent("ValveBiped.Bip01_L_Foot")
		self:ResizeParent("ValveBiped.Bip01_R_Thigh")
		self:ResizeParent("ValveBiped.Bip01_R_Calf")
		self:ResizeParent("ValveBiped.Bip01_R_Foot")
		return
	end

	-- HL1 Models
	self:Resize("Bip01 Head")
	self:Resize("Bone05", Vector(0.5, 0.5, 0.5))
	self:Resize("Bone06")
	-- BMS Models
	self:Resize("ValveBiped.forward")
	self:Resize("jaw05")

	if self:GetParent():GetModel() == "models/zombie/poison.mdl" then
		self:Resize("ValveBiped.Bip01_Head1", Vector(0.8, 0.8, 0.8), Angle(-90, 130, 0))
	else
		self:Resize("ValveBiped.Bip01_Head1")
	end
end