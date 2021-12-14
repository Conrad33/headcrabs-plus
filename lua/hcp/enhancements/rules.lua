local DefaultFile = [[## Characters after ## are ignored
##    "model" OR "class": {
##        class: "",     ## Zombie Class to always use if the original zclass equals req_class or npc_zombie if req_class is not defined
##        req_class: "", ## Zombie Classs required for takeover to occur
##        model: "",     ## Model to use for the bonemerge
##        bg: "",        ## Bodygroup String to enforce on the bonemerge ("04123")
##        headcrab: [req_zombie_class, bodygroup_number, headdcrab_on_number, headcrab_off_number], ## If the model has a headcrab on it, use that instead
##        skin: 0        ## Skin to enforce on bonemerge
##    }
## MAKE SURE TO PUT COMMAS AT THE END OF EACH ENTRY

## Examples
## {
##   "npc_vj_hlr1_hgrunt_serg": {
##       "model": false,
##       "class": "npc_vj_hlrof_zombie_soldier",
##   },
##   "models/player/bms_scientist_female.mdl": {
##       "headcrab": ["npc_zombie", 1, 0, 1],
##       "model": "models/zombies/zombie_sci.mdl",
##   },
##   "models/hassassin.mdl": {
##       "class": false,
##   },
##   "models/player/zombie_soldier.mdl": {
##       "class": "npc_zombine",
##   },
## }

{
	"classormodel": {
		"model": "models/Kleiner.mdl"
	}
}]]

local BMS_Headcrab = {"npc_zombie", 1, 0, 1}
HCP.DefaultRules = {
	-- HL1
	["models/scientist.mdl"] = {req_class = "npc_zombie", class = "monster_zombie", model = false},
	["models/hassassin.mdl"] = {class = false},

	-- BMS + BMS Playermodels Support
	["models/player/bms_kleiner.mdl"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/player/bms_scientist.mdl"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/player/bms_scientist_female.mdl"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/player/bms_hev.mdl"] = {model = "models/zombies/zombie_hev.mdl", headcrab = BMS_Headcrab},
	["models/player/bms_guard.mdl"] = {model = "models/zombies/zombie_guard.mdl", headcrab = BMS_Headcrab},
	["models/player/bms_marine.mdl"] = {model = "models/zombies/zombie_grunt.mdl", headcrab = BMS_Headcrab},

	["models/humans/scientist.mdl"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/humans/scientist_female.mdl"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/humans/guard.mdl"] = {model = "models/zombies/zombie_guard.mdl", headcrab = BMS_Headcrab},
	["models/humans/marine.mdl"] = {model = "models/zombies/zombie_grunt.mdl", headcrab = BMS_Headcrab},

	-- BMS Playermodel Pack V2
	["models/player/blackmesa_scientific.mdl"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/player/blackmesa_scientific_female.mdl"] = {model = "models/zombies/zombie_sci.mdl", headcrab = BMS_Headcrab},
	["models/player/blackmesa_guard.mdl"] = {model = "models/zombies/zombie_guard.mdl", headcrab = BMS_Headcrab},
	["models/player/blackmesa_marine.mdl"] = {model = "models/zombies/zombie_grunt.mdl", headcrab = BMS_Headcrab},

	-- VJ Base HL:R
	["npc_vj_hlr1_scientist"] = {req_class = "npc_zombie", class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlrbs_rosenberg"] = {req_class = "npc_zombie", class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlr1_scientist"] = {req_class = "npc_zombie", class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlr1_scientist"] = {req_class = "npc_zombie", class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlr1_scientist"] = {req_class = "npc_zombie", class = "npc_vj_hlr1_zombie", model = false},
	["npc_vj_hlr1a_scientist"] = {req_class = "npc_zombie", class = "npc_vj_hlr1a_zombie", model = false},

	["npc_vj_hlr1_securityguard"] = {class = "npc_vj_hlrof_zombie_sec", model = false},
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

function HCP.GetRuleTable(ent)
	if not IsValid(ent) then return false end
	local model, class = ent:GetModel(), ent.HCP_RagClass or ent:GetClass()
	return (class and HCP.Rules[class]) or (model and HCP.Rules[model]) or false
end

function HCP.GetRuleTableString(str)
	return str and HCP.Rules[str] or false
end

hook.Add("CreateEntityRagdoll", "HCP_RagdollClass", function(ent, rag)
	if not IsEntity(rag) then return end
	rag.HCP_RagClass = ent:GetClass()
end)

function HCP.LoadRules()
	HCP.Rules = table.Copy(HCP.DefaultRules)

	if not file.Exists("hcp_rules.json", "DATA") then
		file.Write("hcp_rules.json", DefaultFile)
		print("[Headcrabs Plus] Created hcp_rules.json")
		return true
	end

	data = file.Read("hcp_rules.json")
	if not data then return false end

	tab = util.JSONToTable(data:gsub("##.-\n", ""):gsub(",[%c%s]-}", "}"):gsub(",%c-%]", "]"))
	if not tab then
		print("[Headcrabs Plus] Failed to parse hcp_rules.json")
		return false
	end

	for k, v in pairs(tab) do
		HCP.Rules[k] = v
	end

	print("[Headcrabs Plus] Loaded Custom hcp_rules.json")
	return true
end
HCP.LoadRules()

concommand.Add("hcp_reload_rules", function(ply)
	if IsValid(ply) and not ply:IsAdmin() then return end
	local report = IsValid(ply) and function(...) ply:ChatPrint(...) end or function() end

	if HCP.LoadRules() then
		report("Successfully loaded hcp_rules.json!")
	else
		report("Failed to parse hcp_rules.json")
	end
end)