AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "TechCom Jury Rigged 30-Watt" 

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_airgun.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_airgun.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser"
SWEP.LaserColor 			= COLOR_PINK

SWEP.ClipSize 				= 20
SWEP.Damage 				= 60
SWEP.FireDelay 				= 0.15

SWEP.AmmoItem 				= false

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.05

SWEP.FireSound 				= soundscript.AddFire("TRP_LASERSNIPER", "tekka/weapons/weapon_laser_sniper.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.AllowThermals 			= true


SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -7, 0)
}

SWEP.AimOffset = {
	ang = Vector(1, 0, 0),
	pos = Vector(-6.15, -8, 1.601)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
