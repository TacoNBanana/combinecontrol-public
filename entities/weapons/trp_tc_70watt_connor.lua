AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Connors 70-Watt Phased Plasma Rifle"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_mag.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_mag.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

SWEP.Tracer 				= "trp_laser_beam_thicc"
SWEP.LaserColor 			= COLOR_BLUE
SWEP.DoDissolve 			= true

SWEP.ClipSize 				= 50
SWEP.Damage 				= 700
SWEP.FireDelay 				= 0.14

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.4

SWEP.AimCone 				= 0.001
SWEP.HipCone 				= 0.01

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMAPISTOL", "tekka/weapons/plasma_pistol.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"fire01"}
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -4, -2)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.15, -12, -0.97)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
