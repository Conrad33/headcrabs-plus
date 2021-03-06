include("hcp/convars.lua")
include("hcp/enhancements/modifiers.lua")

killicon.Add("npc_headcrab", "hud/killicons/npc_headcrab", Color(255, 80, 0, 255))
killicon.Add("npc_headcrab_fast", "hud/killicons/npc_headcrab_fast", Color(255, 80, 0, 255))
killicon.Add("npc_headcrab_black", "hud/killicons/npc_headcrab_black", Color(255, 80, 0, 255))
killicon.Add("npc_headcrab_poison", "hud/killicons/npc_headcrab_black", Color(255, 80, 0, 255))

-- Some people won't like this, but Garry's Mod is just badly inconsistent sometimes
local function RecvNPCKilledNPC()
	local victim	= "#" .. net.ReadString()
	local inflictor	= net.ReadString()
	local attacker	= net.ReadString()

	GAMEMODE:AddDeathNotice( "#" .. attacker, -1, inflictor ~= "worldspawn" and inflictor or attacker, victim, -1 )
end
net.Receive( "NPCKilledNPC", RecvNPCKilledNPC )

local function HCP_AddOption(panel, convar, name)
	if convar[3] == "bool" then
		local box = panel:CheckBox(name or "#hcp.cv." .. convar[1], "hcp_" .. convar[1])
		if convar[5] then convar[5](panel, box) end
		return box
	elseif convar[3] == "range" then
		local ns = panel:NumSlider(name or "#hcp.cv." .. convar[1], "hcp_" .. convar[1], convar[4][1], convar[4][2], 0)
		if convar[5] then convar[5](panel, ns) end
		return ns
	end
end

local function HCP_Menu(CPanel)
	CPanel:ClearControls()

	-- Take Over Options
	for k, v in pairs(HCP.Convars["takeover"]) do
		HCP_AddOption(CPanel, v)
	end

	-- Instant Kill Options
	local instant_kill = vgui.Create("DForm", CPanel)
	instant_kill:SetName("#hcp.ui.instantkill")
	for k, v in pairs(HCP.Convars["instantkill"]) do
		HCP_AddOption(instant_kill, v)
	end
	CPanel:AddItem(instant_kill)

	-- Scripted Sequences Options
	local sequences = vgui.Create("DForm", CPanel)
	sequences:SetName("#hcp.ui.scripted")
	for k, v in pairs(HCP.Convars["scripted"]) do
		HCP_AddOption(sequences, v)
	end
	CPanel:AddItem(sequences)

	--Poison Headcrab Options
	local poison = vgui.Create("DForm", CPanel)
	poison:SetName("#hcp.ui.poison")
	poison:Help("#hcp.help.poison"):DockMargin(0, 0, 8, 8)
	for k, v in pairs(HCP.Convars["poison"]) do
		HCP_AddOption(poison, v)
	end
	CPanel:AddItem(poison)

	-- Other Options
	local other = vgui.Create("DForm", CPanel)
	other:SetName("#hcp.ui.other")
	for k, v in pairs(HCP.Convars["other"]) do
		HCP_AddOption(other, v)
	end
	if not HCP.GetSabreanInstalled() then
		other:Button("#hcp.help.download_sabrean").DoClick = function() gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=206166550") end
	end
	CPanel:AddItem(other)

	-- About
	local about = vgui.Create("DForm", CPanel)
	about:SetName("#hcp.about")
	about:Help("Headcrabs Plus v" .. HCP.Version):DockMargin(0, 0, 8, 8)
	about:Help("Made by Shakes"):DockMargin(0, 0, 8, 8)
	about:Button("#hcp.about.workshop").DoClick = function() gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=2644919161") end
	about:Button("Reload hcp_rules.json", "hcp_reload_rules")
	about:Button("#hcp.about.bug_report", "hcp_diagnostic"):SetTextColor(Color(200, 0, 0))
	about:Help("")
	CPanel:AddItem(about)
end

local function HCP_Modifiers(CPanel)
	for k, v in pairs(HCP.Convars["modifiers"]) do
		HCP_AddOption(CPanel, v)
	end

	local health = vgui.Create("DForm", CPanel)
	health:SetName("#hcp.ui.health_modifiers")
	for k, v in pairs(HCP.Convars["health_modifiers"]) do
		HCP_AddOption(health, v, "#npc_" .. v[1]:sub(#"health_" + 1))
	end
	CPanel:AddItem(health)

	local dmg = vgui.Create("DForm", CPanel)
	dmg:SetName("#hcp.ui.dmg_modifiers")
	for k, v in pairs(HCP.Convars["dmg_modifiers"]) do
		HCP_AddOption(dmg, v, "#npc_" .. v[1]:sub(#"dmg_" + 1))
	end
	CPanel:AddItem(dmg)

	CPanel:Button("#hcp.ui.reset_modifiers", "hcp_reset_modifiers")
	CPanel:Help("")
end

hook.Add("PopulateToolMenu", "HCP_PopulateSettings", function()
	spawnmenu.AddToolMenuOption("Utilities", "Headcrabs Plus", "HCP_Settings", "#hcp.ui.settings", "", "", HCP_Menu)
	spawnmenu.AddToolMenuOption("Utilities", "Headcrabs Plus", "HCP_Modifiers", "#hcp.ui.modifiers", "", "", HCP_Modifiers)
end)