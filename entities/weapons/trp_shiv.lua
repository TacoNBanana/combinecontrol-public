AddCSLuaFile()

SWEP.Base 					= "tekka_base_melee"

SWEP.PrintName 				= "Shiv"

SWEP.Category 				= "TRP - Melee"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_shank.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_shank.mdl")

SWEP.UseHands 				= true

SWEP.Damage 				= 13
SWEP.DamageType 			= DMG_SLASH

SWEP.HitDelay 				= 0.2
SWEP.MissDelay 				= 0.3

SWEP.Animations = {
	hit = {"hitcenter1", "hitcenter2", "hitcenter3"},
	miss = {"misscenter1", "misscenter2"}
}

SWEP.SoundScripts = {}

SWEP.HoldType 			= "knife"
SWEP.HoldTypeLowered 	= "normal"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -10, 10)
}

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}
