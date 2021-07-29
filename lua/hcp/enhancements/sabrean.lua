-- Reduce memory usage by reusing tables
local Citizens = {1, 4} -- {Normal/Fast Zombie, Poison Zombie}
local Refugees = {7, 4}
local BlueRebels = {3, 1}
local GreenRebels = {2, 1}
local GrayMedics = {4, 2}
local BlueMedics = {5, 2}

HCP.SabreanModels = {
	-- Citizens
	["group01/female_01.mdl"] = Citizens,
	["group01/female_02.mdl"] = Citizens,
	["group01/female_03.mdl"] = Citizens,
	["group01/female_04.mdl"] = Citizens,
	["group01/female_05.mdl"] = Citizens,
	["group01/female_06.mdl"] = Citizens,
	["group01/female_07.mdl"] = Citizens,
	["group01/male_01.mdl"] = Citizens,
	["group01/male_02.mdl"] = Citizens,
	["group01/male_03.mdl"] = Citizens,
	["group01/male_04.mdl"] = Citizens,
	["group01/male_05.mdl"] = Citizens,
	["group01/male_06.mdl"] = Citizens,
	["group01/male_07.mdl"] = Citizens,
	["group01/male_08.mdl"] = Citizens,
	["group01/male_09.mdl"] = Citizens,
	["group02/female_01.mdl"] = Citizens,
	["group02/female_03.mdl"] = Citizens,
	["group02/female_06.mdl"] = Citizens,
	["group02/male_01.mdl"] = Citizens,
	["group02/male_03.mdl"] = Citizens,
	["group02/male_05.mdl"] = Citizens,
	["group02/male_07.mdl"] = Citizens,
	["group02/male_09.mdl"] = Citizens,

	-- Refugees
	["group02/female_02.mdl"] = Refugees,
	["group02/female_04.mdl"] = Refugees,
	["group02/female_07.mdl"] = Refugees,
	["group02/male_02.mdl"] = Refugees,
	["group02/male_04.mdl"] = Refugees,
	["group02/male_06.mdl"] = Refugees,
	["group02/male_08.mdl"] = Refugees,

	-- Rebels Blue
	["group03/female_02.mdl"] = BlueRebels,
	["group03/female_04.mdl"] = BlueRebels,
	["group03/male_02.mdl"] = BlueRebels,
	["group03/male_03.mdl"] = BlueRebels,
	["group03/male_05.mdl"] = BlueRebels,
	["group03/male_07.mdl"] = BlueRebels,
	["group03/male_09.mdl"] = BlueRebels,

	-- Rebels Green
	["group03/female_01.mdl"] = GreenRebels,
	["group03/female_03.mdl"] = GreenRebels,
	["group03/female_06.mdl"] = GreenRebels,
	["group03/female_07.mdl"] = GreenRebels,
	["group03/male_01.mdl"] = GreenRebels,
	["group03/male_04.mdl"] = GreenRebels,
	["group03/male_06.mdl"] = GreenRebels,
	["group03/male_08.mdl"] = GreenRebels,

	-- Medic Gray
	["group03m/female_01.mdl"] = GrayMedics,
	["group03m/female_03.mdl"] = GrayMedics,
	["group03m/female_07.mdl"] = GrayMedics,
	["group03m/male_01.mdl"] = GrayMedics,
	["group03m/male_03.mdl"] = GrayMedics,
	["group03m/male_05.mdl"] = GrayMedics,
	["group03m/male_07.mdl"] = GrayMedics,
	["group03m/male_09.mdl"] = GrayMedics,

	-- Medic Blue
	["group03m/female_02.mdl"] = BlueMedics,
	["group03m/female_04.mdl"] = BlueMedics,
	["group03m/female_06.mdl"] = BlueMedics,
	["group03m/male_02.mdl"] = BlueMedics,
	["group03m/male_04.mdl"] = BlueMedics,
	["group03m/male_06.mdl"] = BlueMedics,
	["group03m/male_08.mdl"] = BlueMedics,

	-- Combine
	["combine_soldier.mdl"] = {false, 5},
	["combine_soldier_prisonguard.mdl"] = {false},
	["zombie_soldier.mdl"] = {false, 5},
	["combine_super_soldier.mdl"] = {false, 8},
	["combine_elite_original.mdl"] = {false, 8},
	["combine_soldier_original.mdl"] = {false, 5},
	["combine_soldier_prisonguard_original.mdl"] = {false, 7},
	["combine_soldier_prisonguard.mdl"] = {false, 7},
	["combine_04.mdl"] = {false, 5},
	["combine_soldier.mdl"] = {false, 5},

	-- Metrocops
	["police.mdl"] = {6, 3},
	["police_fem.mdl"] = {6, 3},
}