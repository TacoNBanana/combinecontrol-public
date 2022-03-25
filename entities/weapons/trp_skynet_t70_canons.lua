AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-70 Plasma Cannons"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_skynet_tankguns.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.Damage 				= 30
SWEP.FireDelay 				= 0.08

SWEP.DoDissolve 			= true
SWEP.Tracer 				= "trp_laser_beam_thicc"
SWEP.LaserColor 			= COLOR_PINK

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.5



SWEP.AimCone 				= 0.03
SWEP.HipCone 				= 0.09

SWEP.FireSound 				= soundscript.AddFire("TEKKA_T70", "tekka/weapons/weapon_laser_smg.wav", 140)

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

SWEP.HoldType 			= "normal"
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
