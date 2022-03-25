-- Web integration
GM.MOTDURL			= ""
GM.SteamGroupURL	= ""
GM.WebsiteURL		= "http://taconbanana.com"

GM.Developers = {}

-- Security
GM.PrivateMode = true

GM.PrivateSteamIDs = {}

GM.TestingClosedMessage = "This server is closed for testing. You are not whitelisted."

GM.WorkshopAddons = {
}

GM.WorkshopMaps = {} -- Should not be needed, maps are automatically made available for download if mounted from the workshop collection

GM.MapRedirect = {
}

--FastDL
GM.FastDLFolders = {}
GM.FastDLFiles = {}

-- Character Creation
GM.QuizEnabled				= false
GM.QuizBanTime				= 15
GM.IntroCinematicEnabled	= false

GM.IntroCamText = {
	"Welcome to Taco N Banana. This is a Half-Life 2-themed serious roleplay server.\n\nIf you were looking for something else, you can disconnect at any time.",
	"Citizens here live under control of the Combine. Create a character to start off - you're a citizen.\n\nStart a business, sell drugs, put up propaganda for the Combine, furnish an apartment, etc.",
	"The Combine forces are located in the Nexus. Breaking the law will get you punished.\n\nThey can and will beat you randomly, arrest you - or worse.\n\nYou can join them in the F3 menu after your character has existed for a day.",
	"City 17 isn't without its underground - you might find contraband, covert rebels, even black market dealers.\n\nBe sure to look around, but be quiet or the CCA may catch you.",
	"Please note this is an administrated server and admins reserve the right to take disciplinary action for whatever they see fit.\n\nCommon bannable things are punching everything, trying to farm stats, and improper names (you need a first and last name).\n\nJust be smart about what you do in-character vs. out-of-character.",
	"Good luck in City 17.\n\nPick a first and last name at the character creation prompt, and have fun!"
}

GM.MinNameLength		= 3
GM.MaxNameLength		= 40
GM.MaxDescLength		= 2000
GM.MaxCharacters		= 15

GM.WeaponRecoilMul 		= Angle(0.5, 1, 0)
GM.PlayerSight 			= 1024
GM.ConsciousnessRate 	= 0.7

GM.CitizenModels = {
	["models/tnb/heads/trp/male_01.mdl"] = 4,
	["models/tnb/heads/trp/male_02.mdl"] = 4,
	["models/tnb/heads/trp/male_03.mdl"] = 4,
	["models/tnb/heads/trp/male_04.mdl"] = 4,
	["models/tnb/heads/trp/male_05.mdl"] = 4,
	["models/tnb/heads/trp/male_06.mdl"] = 4,
	["models/tnb/heads/trp/male_07.mdl"] = 4,
	["models/tnb/heads/trp/male_08.mdl"] = 4,
	["models/tnb/heads/trp/male_09.mdl"] = 4,
	["models/tnb/heads/trp/female_01.mdl"] = 4,
	["models/tnb/heads/trp/female_02.mdl"] = 4,
	["models/tnb/heads/trp/female_03.mdl"] = 2,
	["models/tnb/heads/trp/female_04.mdl"] = 2,
	["models/tnb/heads/trp/female_05.mdl"] = 3,
	["models/tnb/heads/trp/female_38.mdl"] = 4,
	["models/tnb/heads/trp/female_53.mdl"] = 3
}

GM.HullData = {
	Default = {
		Standing = {Vector(-10, -10, 0), Vector(10, 10, 71)},
		Crouching = {Vector(-10, -10, 0), Vector(10, 10, 37)},
		ViewOffset = Vector(0, 0, 66),
		DuckedViewOffset = Vector(0, 0, 40)
	},
	["models/tnb/player/trp/t100.mdl"] = {
		Standing = {Vector(-70, -70, 0), Vector(70, 70, 125)},
		ViewOffset = Vector(0, 0, 105)
	},
	["models/tnb/player/trp/t200.mdl"] = {
		Standing = {Vector(-70, -70, 0), Vector(70, 70, 125)},
		ViewOffset = Vector(0, 0, 105)
	},
	["models/tnb/player/trp/t400.mdl"] = {
		Standing = {Vector(-15, -15, 0), Vector(15, 15, 65)},
		Crouching = {Vector(-15, -15, 0), Vector(15, 15, 50)},
		ViewOffset = Vector(0, 0, 60),
		DuckedViewOffset = Vector(0, 0, 30)
	}
}

-- General Gameplay
GM.UseHunger				= false
GM.FistsHaveEffectOnPlayers	= true
GM.DoorRammingEnabled		= true
GM.UntieOnDeath				= true

GM.CraftRange 				= 96

GM.MaxItemDescLength 		= 300

-- AFK Autokicker
GM.AFKKickerEnabled			= true
GM.AFKPercentage			= 0.90
GM.AFKTime					= 600

-- Cross-Server Transfers
IP_GENERAL					= ""
PORT_CITY					= 27015
PORT_CANAL					= 27016
PORT_OUTLANDS				= 27018
PORT_COAST					= 27017
PORT_NEXUS					= 27019

GM.DataFolders = {
	[LOCATION_CITY]		= "city",
	[LOCATION_CANAL]	= "canals",
	[LOCATION_OUTLANDS]	= "outlands",
	[LOCATION_COAST]	= "coast",
	[LOCATION_NEXUS]	= "nexus"
}

TRANSITPORT_CITY_GATE		= 2
TRANSITPORT_CITY_SEWER		= 3
TRANSITPORT_CITY_COMBINE	= 4
TRANSITPORT_CAVES_ENTRY		= 5
TRANSITPORT_COAST_ENTRY		= 6

-- Donations
GM.BronzeDonorAmount		= 5
GM.SilverDonorAmount		= 30
GM.GoldDonorAmount			= 100

-- Admin stuff
GM.DefaultLogLines 			= 200
GM.MaxLogLines 				= 500
