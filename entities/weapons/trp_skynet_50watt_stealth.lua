AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Skynet STEALTH-MODE 50Watt"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_50watt_stealth.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_50watt_stealth.mdl")

SWEP.UseHands 				= false

SWEP.Tracer 				= "trp_laser"
SWEP.LaserColor 			= COLOR_BLUE

SWEP.ClipSize 				= 30
SWEP.Damage 				= 60
SWEP.FireDelay 				= 0.11

SWEP.AmmoItem 				= "ammo_plasma"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_M203, Vars = {}},
	{Mode = FIREMODE_MASTERKEY, Vars = {}},
	{Mode = FIREMODE_MASTERKEY, Vars = {Name = "Underslung Slugs", Damage = 200, Count = 1, Spread = 0}}	
}

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t870.mdl"] = {1}
}

SWEP.Recoil 				= 0.3

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.045

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMA5", "tekka/weapons/plasma_single5.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2", "shoot3"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, -1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.48, -7, -0.4)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
