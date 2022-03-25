AddCSLuaFile()

SWEP.Base 					= "tekka_base_melee"

SWEP.PrintName 				= "T1000 Blade"

SWEP.Category 				= "TRP Skynet"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_t1000_blade.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_t1000_blade.mdl")

SWEP.UseHands 				= false

SWEP.Damage 				= 1000
SWEP.DamageType 			= DMG_SLASH

SWEP.HitDelay               = 0.1
SWEP.MissDelay              = 0.2

SWEP.Animations = {
	hit = {"hitkill1", "misscenter2", "misscenter1"},
	miss = {"hitcenter2", "hitcenter3"}
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