TOOL.Category = "Headcrabs Plus"
TOOL.Name = "#tool.hcp_zombiecreator.name"

TOOL.ClientConVar["model"] = ""
TOOL.ClientConVar["health"] = "100"
TOOL.ClientConVar["removeheadcrab"] = "0"
TOOL.ClientConVar["zombietype"] = "0"
TOOL.ClientConVar["bzero"] = "0"
TOOL.ClientConVar["override"] = "0"

TOOL.Information = {
	{name = "left",},
	{name = "right"},
	{name = "reload"},
}

local ZombieTypes = {
	"npc_zombie",
	"npc_fastzombie",
	"npc_poisonzombie",
	"npc_zombine",
}

local DefaultConvars = TOOL:BuildConVarList()

function TOOL:LeftClick(tr)
	if CLIENT then return true end

	local ply = self:GetOwner()
	if not ply:CheckLimit("npcs") then return false end

	local zclass = ZombieTypes[self:GetClientNumber("zombietype") or 0] or "npc_zombie"
	local model = self:GetClientInfo("model")

	local zombie = ents.Create(zclass)
	zombie:SetPos(tr.HitPos + tr.HitNormal * 4.4)
	zombie:Spawn()
	zombie:Activate()
	zombie:SetNoDraw(false)
	zombie.IsHeadcrabPlus = true

	if self:GetClientNumber("removeheadcrab") == 1 then zombie:SetBodygroup(1, 0) end

	ply:AddCount("npcs", zombie)
	ply:AddCleanup("npcs", zombie)

	undo.Create(zclass)
		undo.AddEntity(zombie)
		undo.SetPlayer(ply)
	undo.Finish()

	timer.Simple(0.2, function()
		if not IsValid(zombie) then return end
		zombie:SetHealth(self:GetClientNumber("health") or 100)
	end)

	if model and util.IsValidModel(model) then
		local bonemerge = HCP.CreateBonemerge(zombie, model, nil, self:GetClientNumber("removeheadcrab") == 1)
		if self:GetClientNumber("bzero") == 1 then bonemerge:SetBodygroup(1, 1) end
		if not bonemerge:LookupBone("ValveBiped.Bip01_Head1") and self:GetClientNumber("override") ~= 1 then
			bonemerge:Remove()
			timer.Simple(0.01, function() zombie:SetSubMaterial(0, "") end)
		end
	end

	return true
end

function TOOL:RightClick(tr)
	if CLIENT then return true end

	local ply = self:GetOwner()
	if not ply:CheckLimit("npcs") then return false end

	local zclass = ZombieTypes[self:GetClientNumber("zombietype") or 0] or "npc_zombie"

	local zombie = ents.Create(zclass)
	zombie:SetPos(tr.HitPos + tr.HitNormal * 4.4)
	zombie:Spawn()
	zombie:Activate()
	zombie:SetNoDraw(false)
	zombie:SetHealth(self:GetClientNumber("health") or 100)

	ply:AddCount("npcs", zombie)
	ply:AddCleanup("npcs", zombie)

	undo.Create(zclass)
		undo.AddEntity(zombie)
		undo.SetPlayer(ply)
	undo.Finish()

	return true
end

function TOOL:Reload(tr)
	if not IsValid(tr.Entity) then return false end

	self:GetOwner():ConCommand("hcp_zombiecreator_model " .. tr.Entity:GetModel())
	return true
end

if CLIENT then
	function TOOL.BuildCPanel(CPanel)
		CPanel:Help("Creates custom zombies with any valid ValveBiped model")
		CPanel:Help("Most Playermodels and NPC models will work.")
		CPanel:Help("If your Zombie is the default model and you didn't intend for it to be, the model you set does not have a valid Headbone.")

		CPanel:AddControl("ComboBox", {MenuButton = 1, Folder = "zombiecreator", Options = {[ "#preset.default" ] = DefaultConvars}, CVars = table.GetKeys(DefaultConvars)})

		local combobox = vgui.Create("DComboBox", CPanel)
		for k, v in pairs(ZombieTypes) do
			combobox:AddChoice("#" .. v, k, k == 1)
		end
		combobox.OnSelect = function(panel, index, value, data)
			RunConsoleCommand("hcp_zombiecreator_zombietype", tostring(data))
		end
		combobox:ChooseOptionID(HCP.GetConvarInt("zombiecreator_zombietype"))
		CPanel:AddPanel(combobox)

		CPanel:TextEntry("Model", "hcp_zombiecreator_model")
		CPanel:NumSlider("Health", "hcp_zombiecreator_health", 1, 500, 0)

		CPanel:Help("Removes the default Headcrab and restores the models head. Good for models that already have Headcrabs on them.")
		CPanel:CheckBox("Remove default Headcrab", "hcp_zombiecreator_removeheadcrab")

		CPanel:Help("Advanced Options")
		CPanel:CheckBox("Set First Bodygroup to 1", "hcp_zombiecreator_bzero")
		CPanel:CheckBox("Override Headbone Check", "hcp_zombiecreator_override")
	end
end