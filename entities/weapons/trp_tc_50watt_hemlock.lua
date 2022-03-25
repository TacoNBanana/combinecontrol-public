AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom 50-Watt Blue-Rain"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_hemlock.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_hemlock.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser_beam_thicc"
SWEP.LaserColor 			= COLOR_BLUE

SWEP.ClipSize 				= 50
SWEP.Damage 				= 60
SWEP.FireDelay 				= 0.09

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

SWEP.Recoil 				= 0.3

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.045

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMA5", "tekka/weapons/plasma_single5.wav", 140)

SWEP.Animations = {
	reload = "base_reload_empty",
	fire = {"base_fire", "iron_fire"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0.5, 0, -2.5)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2.9, -5, -1.95)
}

SWEP.LoweredOffset = {
	ang = Vector(-12, 0, 0),
	pos = Vector(0.5, 0, -1)
}
