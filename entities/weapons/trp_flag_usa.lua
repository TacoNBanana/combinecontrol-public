AddCSLuaFile()

SWEP.Base 					= "tekka_base_melee"

SWEP.PrintName 				= "American Flag"

SWEP.Category 				= "TRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_flag_usa.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_flag_usa.mdl")

SWEP.UseHands 				= false

SWEP.Damage 				= 50
SWEP.DamageType 			= DMG_SLASH

SWEP.HitDelay               = 0.1
SWEP.MissDelay              = 0.2

SWEP.Animations = {
	hit = {"hitkill1", "misscenter2", "misscenter1"},
	miss = {"hitcenter2", "hitcenter3"}
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