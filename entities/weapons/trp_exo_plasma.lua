AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Exoskeleton Left Shoulder: Plasma Cutter"

SWEP.Category 				= "TRP Exo Weapons"
SWEP.Plasma 				= true

SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_exo_railgun.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_exo_railgun.mdl")


SWEP.Tracer 				= "trp_laser_beam"
SWEP.LaserColor 			= COLOR_RED
SWEP.DoDissolve 			= true
SWEP.ClipSize 				= 100
SWEP.Damage 				= 50
SWEP.FireDelay 				= 0.05

SWEP.UseHands 				= false
SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.1


SWEP.AimCone 				= 0.001
SWEP.HipCone 				= 0.002

SWEP.LoopSounds = {
    loop = "tekka/weapons/plasma_longburst_loop2.wav",
    stop = "tekka/weapons/weapon_chargeup.wav"
}



if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 8
end

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2"}
}

SWEP.HoldType 			= "slam"
SWEP.HoldTypeLowered 	= "slam"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}
