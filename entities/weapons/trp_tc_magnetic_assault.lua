AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Expedition Magnetic Flechette Rifle"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_magnetic_assault.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_magnetic_assault.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"
--SWEP.LaserColor 			= COLOR_BLUE

SWEP.ClipSize 				= 60
SWEP.Damage 				= 60
SWEP.FireDelay 				= 0.12

SWEP.AmmoItem 				= "ammo_plasma"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.2

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

SWEP.FireSound 				= soundscript.AddFire("WEAPON_LASER_SNIPER", "tekka/weapons/weapon_laser_sniper.wav", 140)


SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}


SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -8, -1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.309, -12, 0.52)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
