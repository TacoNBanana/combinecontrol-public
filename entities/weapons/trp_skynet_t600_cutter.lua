AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-600 Plasma Cutter"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_70watt.mdl")
SWEP.WorldModel 			= ""

SWEP.AttachmentOverride 	= "anim_attachment_RH"

SWEP.UseHands 				= false
SWEP.DoDissolve 			= true
SWEP.Tracer 				= "trp_laser_electric"
SWEP.LaserColor 			= COLOR_GREEN

SWEP.ClipSize 				= 100
SWEP.Damage 				= 30
SWEP.FireDelay 				= 0.05



SWEP.AmmoItem 				= "ammo_plasma_lmg"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.02

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t600_repro_support.mdl"] = {0, 2},
}

SWEP.LoopSounds = {
    loop = "tekka/weapons/plasma_longburst_loop2.wav",
    stop = "tekka/weapons/weapon_chargeup.wav"
}

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2", "shoot3"}
}

SWEP.HoldType 			= "pistol"
SWEP.HoldTypeLowered 	= "slam"

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 8

end

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -5, -0.6)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
