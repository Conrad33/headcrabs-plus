--[[
	HCP.Rules = {
		[model] = {
			class = "", -- Zombie Class to always use if original class is npc_zombie or req_class
			req_class = "", -- Zombie Classs required 
			model = "", -- Model to change bonemerge to
			bg = "", -- Bodygroup String to enforce on bonemerge
			bgz = "", -- Bodygroup String to enforce on zombie
			skin = "", -- Skin to enforce on bonemerge
		}
	}
]]

HCP.Rules = {
	-- HL1 Scientist
	["models/scientist.mdl"] = {class = "monster_zombie", req_class = "npc_zombie", model = false},

	-- BMS + BMS Playermodels Support
	["models/player/bms_kleiner.mdl"] = {model = "models/zombies/zombie_sci.mdl", bg = "01"},
	["models/player/bms_scientist.mdl"] = {model = "models/zombies/zombie_sci.mdl", bg = "01"},
	["models/player/bms_scientist_female.mdl"] = {model = "models/zombies/zombie_sci.mdl", bg = "01"},
	["models/humans/scientist.mdl"] = {model = "models/zombies/zombie_sci.mdl", bg = "01"},
	["models/humans/scientist_female.mdl"] = {model = "models/zombies/zombie_sci.mdl", bg = "01"},
	["models/player/bms_hev.mdl"] = {model = "models/zombies/zombie_hev.mdl", bg = "01"},

	["models/player/bms_guard.mdl"] = {model = "models/zombies/zombie_guard.mdl", bg = "01"},
	["models/humans/guard.mdl"] = {model = "models/zombies/zombie_guard.mdl", bg = "01"},

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

	["models/vj_hlr/opfor/strooper.mdl"] = {class = false},
	["models/vj_hlr/opfor/massn.mdl"] = {class = false},
	["models/vj_hlr/hl1/rgrunt_black.mdl"] = {class = false},
}