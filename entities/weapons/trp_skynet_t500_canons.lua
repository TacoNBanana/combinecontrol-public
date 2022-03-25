AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-500 Plasma Cannon"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_skynet_tankguns.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_t400_weapons.mdl")

SWEP.UseHands 				= false

SWEP.Damage 				= 20
SWEP.FireDelay 				= 0.06

SWEP.Tracer 				= "trp_laser"
SWEP.LaserColor 			= COLOR_PURPLE

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.5



SWEP.AimCone 				= 0.03
SWEP.HipCone 				= 0.09

SWEP.FireSound 				= soundscript.AddFire("TEKKA_PLASMASINGLE3", "tekka/weapons/plasma_single3.wav", 140)

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 14
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot_right1", "shoot_left1"}
}

SWEP.HoldType 			= "fist"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -12, -2)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -8, 0)
}

SWEP.LoweredOffset = {
	ang = Vector(-10, 0, 0),
	pos = Vector(0, 0, 0)
}

