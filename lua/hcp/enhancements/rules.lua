local DefaultFile = [[
## Characters after ## are ignored
##    "model" OR "class": {
##        class: "",     ## Zombie Class to always use if the original zclass equals req_class
##        req_class: "", ## Zombie Classs required for takeover to occur (defaults to npc_zombie)
##        model: "",     ## Model to use for the bonemerge
##        bg: "",        ## Bodygroup String to enforce on the bonemerge ("04123")
##        headcrab: [req_zombie_class, bodygroup_number, headdcrab_on_number, headcrab_off_number], ## If the model has a headcrab on it, use that instead
##        skin: 0        ## Skin to enforce on bonemerge
##    }

## MAKE SURE TO PUT COMMAS AT THE END OF EACH ENTRY
## EXCEPT FOR THE LAST ENTRY IN EACH LISTS. SEE THE EXAMPLES BELOW FOR MORE HELP

## Examples
## {
##  "npc_vj_hlr1_hgrunt_serg": {
##      "model": false,
##      "class": "npc_vj_hlrof_zombie_soldier"
##  },
##  "models/player/bms_scientist_female.mdl": {
##      "headcrab": [
##          "npc_zombie",
##          1.0,
##          0.0,
##          1.0
##      ],
##      "model": "models/zombies/zombie_sci.mdl"
##  },
##  "models/hassassin.mdl": {
##      "class": false
##  }
## }

{
	"classormodel": {
		"model": "models/Kleiner.mdl"
	}
}
]]
local BMS_Headcrab = {"npc_zombie", 1, 0, 1}
HCP.DefaultRules = {
	-- HL1
	["models/scientist.mdl"] = {class = "monster_zombie", model = false},
	["models/hassassin.mdl"] = {class = false},

	-- BMS + BMS Playermodels Support
	["models/player/bms_kleiner.mdl"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/player/bms_scientist.mdl"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/player/bms_scientist_female.mdl"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/humans/scientist.mdl"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/humans/scientist_female.mdl"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/player/bms_hev.mdl"] = {model = "models/zombies/zombie_hev.mdl", headcrab = BMS_Headcrab},

	["models/player/bms_guard.mdl"] = {model = "models/zombies/zombie_guard.mdl", headcrab = BMS_Headcrab},
	["models/humans/guard.mdl"] = {model = "models/zombies/zombie_guard.mdl", headcrab = BMS_Headcrab},

	["models/player/bms_marine.mdl"] = {model = "models/zombies/zombie_grunt.mdl", headcrab = BMS_Headcrab},
	["models/humans/marine.mdl"] = {model = "models/zombies/zombie_grunt.mdl", headcrab = BMS_Headcrab},

	-- VJ Base HL:R
	["npc_vj_hlr1_scientist"] = {class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlrbs_rosenberg"] = {class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlr1_scientist"] = {class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlr1_scientist"] = {class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlr1_scientist"] = {class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlr1a_scientist"] = {class = "npc_vj_hlr1a_zombie", model = false},

	["npc_vj_hlr1_securityguard"] = {class = "npc_vj_hlrof_zombie_sec", model = false},
	["npc_vj_hlrof_otis"] = {class = "npc_vj_hlrof_zombie_sec", model = false},
	["npc_vj_hlr1a_securityguard"] = {class = "npc_vj_hlrof_zombie_sec", model = false},

	["npc_vj_hlrof_hgrunt"] = {class = "npc_vj_hlrof_zombie_soldier", model = false},
	["npc_vj_hlr1_hgrunt"] = {class = "npc_vj_hlrof_zombie_soldier", model = false},
	["npc_vj_hlrof_hgrunt_eng"] = {class = "npc_vj_hlrof_zombie_soldier", model = false},
	["npc_vj_hlrof_hgrunt_med"] = {class = "npc_vj_hlrof_zombie_soldier", model = false},
	["npc_vj_hlr1_hgrunt_serg"] = {class = "npc_vj_hlrof_zombie_soldier", model = false},
	["npc_vj_hlr1a_hgrunt"] = {class = "npc_vj_hlrof_zombie_soldier", model = false},

	["models/vj_hlr/opfor/strooper.mdl"] = {class = false},
	["models/vj_hlr/opfor/massn.mdl"] = {class = false},
	["models/vj_hlr/hl1/rgrunt_black.mdl"] = {class = false},
}

local function FormatModelRule(str)
	return str and str:Replace("/blackmesa", "/bms"):Replace("_scientific", "_scientist") or ""
end

function HCP.GetRuleTable(ent)
	local model, class = ent:GetModel(), ent:GetClass()
	return (class and HCP.Rules[class]) or (model and HCP.Rules[FormatModelRule(model)]) or false
end

function HCP.GetRuleTableModel(model)
	return model and HCP.Rules[FormatModelRule(model)] or false
end

function HCP.LoadRules()
	HCP.Rules = table.Copy(HCP.DefaultRules)

	if not file.Exists("hcp_rules.json", "DATA") then
		file.Write("hcp_rules.json", DefaultFile)
		return true
	end

	data = file.Read("hcp_rules.json")
	if not data then return false end

	tab = util.JSONToTable(data:gsub("##.-\n", ""))
	if not tab then return false end

	for k, v in pairs(tab) do
		HCP.Rules[k] = v
	end

	print("[Headcrabs Plus] Loaded Custom hcp_rules.json")
	return true
end
HCP.LoadRules()

concommand.Add("hcp_reload_rules", function(ply)
	if IsValid(ply) and not ply:IsAdmin() then return end
	local report = IsValid(ply) and function(...) ply:ChatPrint(...) print(...) end or print

	if HCP.LoadRules() then
		report("Successfully loaded hcp_rules.json!")
	else
		report("Failed to load hcp_rules.json (it may contain an error).")
	end
end)