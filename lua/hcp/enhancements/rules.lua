--[[
	HCP.Rules = {
		[model] = {
			class = "", -- Zombie Class to always use if original class is npc_zombie or req_class
			req_class = "", -- Zombie Classs required 
			model = "", -- Model to change bonemerge to
			bg = "", -- Bodygroup String to enforce on bonemerge
			headcrab = {class, #bg, #on, #off} -- If the model has a headcrab on it, use that
			skin = "", -- Skin to enforce on bonemerge
		}
	}
]]
local BMS_Headcrab = {"npc_zombie", 1, 0, 1}
HCP.Rules = {
	-- HL1
	["models/scientist"] = {class = "monster_zombie", req_class = "npc_zombie", model = false},
	["models/hassassin"] = {class = false},

	-- BMS + BMS Playermodels Support
	["models/player/bms_kleiner"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/player/bms_scientist"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/player/bms_scientist_female"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/humans/scientist"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/humans/scientist_female"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/player/bms_hev"] = {model = "models/zombies/zombie_hev.mdl", headcrab = BMS_Headcrab},

	["models/player/bms_guard"] = {model = "models/zombies/zombie_guard.mdl", headcrab = BMS_Headcrab},
	["models/humans/guard"] = {model = "models/zombies/zombie_guard.mdl", headcrab = BMS_Headcrab},

	["models/player/bms_marine"] = {model = "models/zombies/zombie_grunt.mdl", headcrab = BMS_Headcrab},
	["models/humans/marine"] = {model = "models/zombies/zombie_grunt.mdl", headcrab = BMS_Headcrab},

	-- VJ Base HL:R
	["npc_vj_hlr1_scientist"] = {req_class = "npc_zombie", class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlrbs_rosenberg"] = {req_class = "npc_zombie", class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlr1_scientist"] = {req_class = "npc_zombie", class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlr1_scientist"] = {req_class = "npc_zombie", class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlr1_scientist"] = {req_class = "npc_zombie", class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlr1a_scientist"] = {req_class = "npc_zombie", class = "npc_vj_hlr1a_zombie", model = false},

	["npc_vj_hlr1_securityguard"] = {req_class = "npc_zombie", class = "npc_vj_hlrof_zombie_sec", model = false},
	["npc_vj_hlrof_otis"] = {req_class = "npc_zombie", class = "npc_vj_hlrof_zombie_sec", model = false},
	["npc_vj_hlr1a_securityguard"] = {req_class = "npc_zombie", class = "npc_vj_hlrof_zombie_sec", model = false},

	["npc_vj_hlrof_hgrunt"] = {req_class = "npc_zombie", class = "npc_vj_hlrof_zombie_soldier", model = false},
	["npc_vj_hlr1_hgrunt"] = {req_class = "npc_zombie", class = "npc_vj_hlrof_zombie_soldier", model = false},
	["npc_vj_hlrof_hgrunt_eng"] = {req_class = "npc_zombie", class = "npc_vj_hlrof_zombie_soldier", model = false},
	["npc_vj_hlrof_hgrunt_med"] = {req_class = "npc_zombie", class = "npc_vj_hlrof_zombie_soldier", model = false},
	["npc_vj_hlr1_hgrunt_serg"] = {req_class = "npc_zombie", class = "npc_vj_hlrof_zombie_soldier", model = false},
	["npc_vj_hlr1a_hgrunt"] = {req_class = "npc_zombie", class = "npc_vj_hlrof_zombie_soldier", model = false},

	["models/vj_hlr/opfor/strooper"] = {class = false},
	["models/vj_hlr/opfor/massn"] = {class = false},
	["models/vj_hlr/hl1/rgrunt_black"] = {class = false},
}

local function FormatModelRule(str)
	return str:StripExtension():Replace("/blackmesa", "/bms"):Replace("_scientific", "_scientist")
end

function HCP.GetRuleTable(ent)
	local model, class = ent:GetModel(), ent:GetClass()
	return HCP.Rules[class] or HCP.Rules[FormatModelRule(model)]
end

function HCP.GetRuleTableModel(model)
	return HCP.Rules[FormatModelRule(model)]
end