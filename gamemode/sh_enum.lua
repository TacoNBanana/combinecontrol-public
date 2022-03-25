CB_ALL	= 0
CB_IC	= 1
CB_OOC	= 2

TAB_SYSTEM		= 0x1
TAB_OOC			= 0x2
TAB_IC			= 0x4
TAB_RADIO		= 0x8
TAB_PRIVMSG		= 0x10
TAB_ADMIN		= 0x20
TAB_LOOC 		= 0x40
TAB_ALL			= 0xff

TAB_DEFAULT		= TAB_ALL
TAB_CURRENT		= -1

CC_CREATE 			= 0
CC_CREATESELECT 	= 1
CC_CREATESELECT_C 	= 2
CC_SELECT 			= 3
CC_SELECT_C 		= 4

IRON_HOLSTERED 		= 0
IRON_HOLSTERED2IDLE = 1
IRON_IDLE 			= 2
IRON_IDLE2AIM 		= 3
IRON_AIM 			= 4

RELOADTYPE_NONE		= 0
RELOADTYPE_NORMAL	= 1
RELOADTYPE_SHOTGUN	= 2

SONG_IDLE 		= 0
SONG_ALERT 		= 1
SONG_ACTION 	= 2
SONG_STINGER 	= 3

DOOR_UNBUYABLE			= 0
DOOR_BUYABLE 			= 1
DOOR_COMBINEOPEN 		= 2
DOOR_COMBINELOCK 		= 3
DOOR_BUYABLE_ASSIGNABLE = 4

NEWBIE_STATUS_NEW = 0
NEWBIE_STATUS_OLD = 1

TRAIT_NONE 		= 2^0

LANG_ENGLISH	= 2^0
LANG_RUSSIAN	= 2^1
LANG_CHINESE	= 2^2
LANG_JAPANESE	= 2^3
LANG_SPANISH	= 2^4
LANG_FRENCH		= 2^5
LANG_GERMAN		= 2^6
LANG_ITALIAN	= 2^7
--LANG_CITY		= 2^8 -- "city speak" a combination of slang and different languages used in San Angeles. might be tied to a trait later on that only criminals can use

--teams need reorganising for tekka
TEAM_CITIZEN		= 1
TEAM_SKYNET			= 2
TEAM_REPROG 		= 3
TEAM_GREY 			= 4
TEAM_AOF 			= 5
TEAM_UNCONNECTED	= 1001

MICROPHONE_BIG 		= 50
MICROPHONE_SMALL 	= 56


--drugs need redoing
DRUG_BREEN 		= 1
DRUG_MEDKIT 	= 2
DRUG_VODKA 		= 3
DRUG_ANTLION 	= 4
DRUG_EXTRACT 	= 5
DRUG_COP		= 6

BADGE_BETATEST	= 1
BADGE_BETASCR	= 2
BADGE_BIRTHDAY	= 4
BADGE_BUGGER	= 8

LOCATION_CITY = 1
LOCATION_CANAL = 2
LOCATION_OUTLANDS = 3
LOCATION_COAST = 4
LOCATION_NEXUS = 5

EQUIPMENT_TO_TEXT = {}

local function AddEquipment(index, enum, name)
	_G["EQUIPMENT_" .. enum] = index
	EQUIPMENT_TO_TEXT[index] = name
end

AddEquipment(1, "HEAD", "Headgear")
AddEquipment(2, "EYES", "Eyewear")
AddEquipment(3, "MASK", "Mask")
AddEquipment(4, "BODY", "Clothing")
AddEquipment(5, "EXO", "Exosuit")
AddEquipment(6, "BACK", "Backpack")
AddEquipment(7, "ARM_L", "Left Armband")
AddEquipment(8, "ARM_R", "Right Armband")
AddEquipment(9, "PRIMARY", "Primary Weapon")
AddEquipment(10, "SECONDARY", "Secondary Weapon")
AddEquipment(11, "MELEE", "Melee Weapon")
AddEquipment(12, "GRENADE", "Grenade")
AddEquipment(13, "EQUIP1", "Main Equipment")
AddEquipment(14, "EQUIP2", "Backup Equipment")
AddEquipment(15, "RADIO", "Radio")
AddEquipment(16, "LIGHT", "Light")
AddEquipment(17, "ARMOR", "Armor")

BUSINESS_NONE 			= -1
BUSINESS_GENERIC 		= 2^1
BUSINESS_CLOTHING 		= 2^2
BUSINESS_MEDICAL 		= 2^3
BUSINESS_WEAPONRY 		= 2^4
BUSINESS_ILLEGAL 		= 2^5
BUSINESS_QUARTERMASTER 	= 2^6

--[[
BUSINESS_NONE 		= -1
BUSINESS_GENERIC 	= 2^1
BUSINESS_CLOTHING 	= 2^2
BUSINESS_MEDICAL 	= 2^3
BUSINESS_WEAPONRY 	= 2^4
BUSINESS_ILLEGAL 	= 2^5
--BUSINESS_SPECIAL 	= 2^6 --tekka placeholder, all of the others are just slightly reorganised and reused
]]


FIREMODE_SEMI 				= 1
FIREMODE_BURST2 			= 2
FIREMODE_BURST3 			= 3
FIREMODE_AUTO 				= 4
FIREMODE_RPG 				= 5
FIREMODE_M203 				= 6
FIREMODE_MASTERKEY 			= 7
FIREMODE_NONE 				= 8
FIREMODE_BINOC 				= 9
FIREMODE_EMP 				= 10
FIREMODE_FLAMETHROWER 		= 11
FIREMODE_CANNON 			= 12
FIREMODE_ACID 				= 13
FIREMODE_RAILGUN 			= 14
FIREMODE_EXTINGUISHER		= 15
FIREMODE_TESLA 				= 16

SCK_MODEL 			= 1
SCK_SPRITE 			= 2
SCK_QUAD 			= 3
SCK_LASER 			= 4

SPEC_NONE 			= 0
SPEC_PENETRATE 		= 1 -- Allows the hitscan projectile to penetrate certain materials
SPEC_TRANQ 			= 2 -- Applies the damage as 'consiousness' damage
SPEC_BURN 			= 3 -- Sets entities on fire
SPEC_DOORBREACH		= 4 -- Allows the weapon to breach doors
SPEC_CUSTOM 		= 5 -- Calls a custom function on firing

MAT_MULTIPLIERS 	= { -- Material based multipliers for weapon penetration
	[MAT_FOLIAGE]		= 5,
	[MAT_SLOSH]			= 3,
	[MAT_ALIENFLESH]	= 2,
	[MAT_ANTLION]		= 2,
	[MAT_BLOODYFLESH]	= 2,
	[MAT_FLESH]			= 2,
	[45]				= 2,	-- Metrocop heads don't have enumerations
	[MAT_DIRT]			= 2,
	[MAT_GRASS]			= 2,
	[MAT_WOOD]			= 1.5,
	[MAT_SAND]			= 1.3,
	[MAT_GLASS]			= 1.2,
	[MAT_CLIP]			= 1,
	[MAT_COMPUTER]		= 1,
	[MAT_PLASTIC]		= 1,
	[MAT_TILE]			= 1,
	[MAT_CONCRETE]		= 1,
	[MAT_GRATE]			= 0.8,
	[MAT_VENT]			= 0.8,
	[MAT_METAL]			= 0.3
}

CRAFTVIS_ALWAYS 			= 2^0
CRAFTVIS_ALLINGREDIENTS 	= 2^2
CRAFTVIS_ENTITY 			= 2^3
CRAFTVIS_TOOLS				= 2^4
CRAFTVIS_FIRSTINGREDIENT 	= 2^5

ITEM_NONE 				= 0 -- No location, used for items that were just made
ITEM_PLAYER 			= 1 -- In a player's inventory
ITEM_WORLD 				= 2 -- In the world somewhere
-- ITEM_CONTAINER 			= 3 -- In a container
ITEM_AUGMENT			= 4 -- In a player, installed as an augmentation

INVTYPE_SELF 			= 1
INVTYPE_ADMIN 			= 2
INVTYPE_PATDOWN 		= 3
INVTYPE_BUSINESS		= 4

CONDITION_GOOD 				= 1
CONDITION_DAMAGED 			= 2
CONDITION_HEAVILYDAMAGED 	= 3
CONDITION_BROKEN 			= 4

LOG_NONE 		= 0
LOG_SECURITY 	= 1
LOG_SANDBOX 	= 2
LOG_ITEMS 		= 3
LOG_CHARACTER 	= 4
LOG_CHAT 		= 5
LOG_ADMIN 		= 6
LOG_DEVELOPER 	= 7

META_CHAR 	= 1
META_ITEM 	= 2
META_PLY 	= 3

THROW_NORMAL 	= 1
THROW_ROLL 		= 2
THROW_LOB 		= 3
--red / green / blue order
COLOR_GREEN 	= Color(52, 216, 56)
COLOR_PURPLE 	= Color(150, 100, 255)
COLOR_BLUE 		= Color(0, 100, 255)
COLOR_RED 		= Color(255, 0, 0)
COLOR_ORANGE 	= Color(255, 191, 0)
COLOR_PINK 		= Color(255, 0, 255)

OVERLAY_NONE 		= 0
OVERLAY_NVG 		= 1
OVERLAY_TARGET 		= 2
OVERLAY_THERMAL 	= 3

ARMOR = {}
ARMOR.Light = 16
ARMOR.Medium = 22
ARMOR.Heavy = 30

-- Only used for debugging, not the actual damage values used
SHOTGUN_PELLETS = 8

DAMAGE = {}
DAMAGE.Pistol = {
	Light = 11,
	Normal = 13,
	Heavy = 16,
	Magnum = 22
}
DAMAGE.SMG = {
	Normal = 16,
	Heavy = 18
}
DAMAGE.Rifle = {
	Normal = 22,
	Heavy = 24
}
DAMAGE.LMG = {
	Normal = 23,
	Heavy = 24
}
DAMAGE.Sniper = {
	DMR = 28,
	Normal = 30,
	Heavy = 33,
	NTW = 120
}
DAMAGE.Shotgun = {
	Normal = 90 / SHOTGUN_PELLETS
}
DAMAGE.RPG = {
	Normal = 300
}
