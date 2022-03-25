AddCSLuaFile()

SWEP.Base 					= "tekka_base_melee"

SWEP.PrintName 				= "Hammer"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_hammer.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_hammer.mdl")

SWEP.UseHands 				= true

SWEP.Damage 				= 10
SWEP.DamageType 			= DMG_CLUB

SWEP.HitDelay               = 0.6
SWEP.MissDelay              = 0.3

SWEP.Animations = {
	hit = {"hitcenter1", "hitcenter2", "hitcenter3"},
	miss = {"misscenter1", "misscenter2"}
}

SWEP.SoundScripts = {}

SWEP.HoldType 			= "melee"
SWEP.HoldTypeLowered 	= "normal"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -10, 10)
}

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}