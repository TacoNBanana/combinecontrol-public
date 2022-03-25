-- Not every pool needs to have a rate defined, if a pool doesn't have a rate it won't be able to be spawned on it's own but you can include it in others

GM.Loot = {
	Enabled = false,
	Pools = {
		-- Generic
		loot_clothing_drifter = {
			clothing_drifter_black = 1,
			clothing_drifter_brown = 1
		},

		loot_clothing_leatherjacket = {
			clothing_leatherjacket_black = 1,
			clothing_leatherjacket_brown = 1
		},

		loot_clothing_parka = {
			clothing_parka_blue = 1,
			clothing_parka_charcoal = 1,
			clothing_parka_coyote = 1,
			clothing_parka_olive = 1,
			clothing_parka_red = 1,
			clothing_parka_teal = 1
		},

		loot_clothing_basic = {
			clothing_casual = 1,
			clothing_dirty = 1,
			loot_clothing_drifter = 1,
			clothing_jacket = 1,
			loot_clothing_leatherjacket = 1,
			loot_clothing_parka = 1,
			clothing_survivor = 1,
			clothing_workshirt = 1
		},

		loot_clothing_eyewear_rare = {
			eyes_aviators = 1
		},

		loot_clothing_eyewear_common = {
			eyes_glasses = 1,
			eyes_glasses_half = 1,
			eyes_glasses_thick = 1,
			eyes_shades = 1
		},

		loot_clothing_eyewear = {
			loot_clothing_eyewear_rare = 5,
			loot_clothing_eyewear_common = 95
		},

		loot_clothing_hat_common = {
			hat_bandana_green = 1.5,
			hat_bandana_red = 1.5,
			hat_baseball = 3,
			hat_beanie = 1.5,
			hat_beanie_alt = 1.5,
			hat_beret_red = 1,
			hat_beret_green = 1,
			hat_beret_black = 1
		},

		loot_clothing_hat = {
			loot_clothing_hat_common = 4,
			hat_cowboy = 1
		},

		loot_clothing_mask = {
			mask_facewrap = 1,
			mask_facewrap_blue = 1,
			mask_facewrap_red = 1,
			mask_shemagh = 3,
			balaclava = 3,
			gasmask_respirator = 3,
			gasmask_basic = 1
		},

		loot_clothing_backpack = {
			backpack_coyote = 2,
			backpack_messenger = 3,
			backpack_pilgrim = 1,
			backpack_scav = 1,
			backpack_sling = 3
		},

		loot_clothing_accessories = {
			loot_clothing_eyewear = 3,
			loot_clothing_hat = 4,
			loot_clothing_mask = 2,
			loot_clothing_backpack = 1
		},

		-- Domestic
		loot_domestic_junk = {
			junk_alarmclock = 1,
			junk_clipboard = 1,
			junk_dinnerplate = 1,
			junk_dollars = 1,
			junk_keychain = 1,
			junk_mug = 1,
			junk_newspaper = 1,
			junk_spoon = 1,
			junk_teapot = 1,
		},

		loot_domestic_useful = {
			junk_matches = 1,
			junk_blanket = 1,
			mat_meds = 1,
			light_flashlight = 3,
			junk_waterbottle = 2,
			map = 1,
			food_waterbottle = 1,
			food_mre = 1,
			binoculars = 1
		},

		loot_domestic_rare = {
			junk_bedroll = 2,
			junk_toothbrush = 1,
			junk_toiletpaper = 2,
			junk_soap = 1,
		},

		loot_ammo_domestic = {
			ammo_pistol = 4,
			ammo_shotgun = 3,
			ammo_rifle = 2,
			ammo_sniper = 1
		},

		loot_weapons_domestic = {
			weapon_glock = 3,
			weapon_m9 = 2,
			weapon_44 = 2,
			weapon_mossberg = 1,
			weapon_m4_adar = 1,
			weapon_garand = 1
		},

		pool_domestic = {
			loot_domestic_junk = 8,
			loot_domestic_useful = 4,
			loot_domestic_rare = 2,
			loot_ammo_domestic = 2,
			loot_weapons_domestic = 1,
			loot_clothing_basic = 4,
			loot_clothing_accessories = 2
		},

		-- Tech
		loot_tech_junk = {
			junk_capacitors = 3,
			junk_circuitbreaker = 1,
			junk_keyboard = 1,
			junk_lightbulb = 1,
			junk_pcb = 3,
			junk_powerconduit = 2,
			junk_wires = 3,
			junk_nails = 1,
			junk_screws = 1
		},

		loot_tech_useful = {
			light_flashlight = 5,
			--repairkit = 2,
			junk_ducttape = 4,
			junk_electricaltape = 3,
			junk_drill = 1,
			junk_psu = 3,
			junk_harddrive = 3,
			zipties = 2,
			radio_basic = 3,
			binoculars = 2,
			map = 1
		},

		loot_tech_rare = {
			--repairkit = 4,
			junk_rope = 4,
			junk_jackhammer = 1,
			junk_jerrycan = 3,
			junk_toolbox = 2,
			junk_geigercounter = 3,
			junk_carbattery = 3,
			junk_controller = 3,
			junk_transmitter = 3
		},

		pool_tech = {
			loot_tech_junk = 5,
			loot_tech_useful = 3,
			loot_tech_rare = 1
		},

		-- Military
		loot_military_weapons_common = {
			weapon_glock = 2,
			weapon_m9 = 2,
			weapon_mp5 = 2,
			weapon_mp7 = 1
		},

		loot_military_weapons_rare = {
			weapon_m4a1 = 2,
			weapon_44 = 2,
			weapon_mossberg = 2,
			weapon_m16a2 = 3,
			weapon_m24 = 1
		},

		loot_military_ammo = {
			ammo_lmg = 3,
			ammo_pistol = 4,
			ammo_shotgun = 4,
			ammo_rifle = 4,
			ammo_sniper = 3,
			ammo_40mm = 2,
			ammo_rpg = 1,
		},

		loot_military_armor = {
			vest_military = 1,
			vest_molle = 1,
			vest_mcv = 4,
			vest_specialist = 2
		},

		pool_military = {
			loot_military_weapons_common = 4,
			loot_military_weapons_rare = 2,
			loot_military_ammo = 4,
			loot_military_armor = 2
		},

		-- Scav
		loot_scav = {
			armor_balkan = 1,
			vest_scout = 1,
			armor_militia = 1,
			helmet_tanker = 1,
			gasmask_respirator = 3,
			gasmask_basic = 1,
			chemlight = 2,
			binoculars = 2,
			food_mre = 3,
			food_waterbottle = 3,
			radio_basic = 1,
			compass = 1,
			map = 2
		},

		pool_scav = {
			loot_domestic_junk = 6,
			loot_domestic_useful = 2,
			loot_clothing_basic = 3,
			loot_clothing_accessories = 2,
			loot_weapons_domestic = 2,
			loot_tech_junk = 6,
			loot_tech_useful = 2,
			loot_scav = 3
		}
	},
	Rates = { -- Minimum amount of players, longest delay between drops, shortest delay between drops
		pool_domestic = {20, 300, 150},
		pool_tech = {20, 300, 150},
		pool_military = {30, 600, 300},
		pool_scav = {15, 200, 150}
	},
	RateLimit = {
		MaxAttempts = 10,
		RechargeRate = 360
	}
}
