AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-831 Plasma Cutter"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_70watt.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.Tracer 				= "trp_laser_electric"
SWEP.LaserColor 			= COLOR_RED
SWEP.AttachmentOverride 	= "minigun"
SWEP.DoDissolve 			= true
SWEP.Damage 				= 50
SWEP.FireDelay 				= 0.07


SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.02

SWEP.LoopSounds = {
    loop = "tekka/weapons/weapon_tesla_loop.wav",
    stop = "tekka/weapons/weapon_chargeup.wav"
}

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2", "shoot3"}
}

SWEP.HoldType 			= "slam"
SWEP.HoldTypeLowered 	= "duel"

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 14

end

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -18, -1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -20, 0)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t831.mdl"] = {2, 2},
}