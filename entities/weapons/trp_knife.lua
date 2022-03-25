AddCSLuaFile()

SWEP.Base 					= "tekka_base_melee"

SWEP.PrintName 				= "Knife"

SWEP.Category 				= "TRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/weapons/cstrike/c_knife_t.mdl")
SWEP.WorldModel 			= Model("models/weapons/w_knife_t.mdl")

SWEP.UseHands 				= true

SWEP.Damage 				= 10
SWEP.DamageType 			= DMG_SLASH

SWEP.HitDelay               = 0.3
SWEP.MissDelay              = 0.4

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