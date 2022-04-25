AddCSLuaFile()

SWEP.Base 					= "tekka_base_melee"

SWEP.PrintName 				= "Metal pipe"

SWEP.Category 				= "TRP - Melee"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_pipe.mdl")
SWEP.WorldModel 			= Model("models/props_canal/mattpipe.mdl")

SWEP.UseHands 				= true

SWEP.Damage 				= 22
SWEP.DamageType 			= DMG_CLUB

SWEP.HitDelay 				= 0.8
SWEP.MissDelay 				= 0.6

SWEP.Animations = {
	hit = {"hitcenter1", "hitcenter2", "hitcenter3"},
	miss = {"misscenter1", "misscenter2"}
}

SWEP.SoundScripts = {}

SWEP.HoldType 			= "melee2"
SWEP.HoldTypeLowered 	= "normal"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -10, 10)
}

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}
