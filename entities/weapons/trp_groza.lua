AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Groza"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_groza.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_groza.mdl")

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 20
SWEP.Damage 				= 50
SWEP.FireDelay 				= 0.10

SWEP.AmmoItem 				= "ammo_rifle"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 0.7



SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.04

SWEP.FireSound 				= soundscript.AddFire("WEAPON_RTAK", "tekka/weapons/weapon_rtak.wav", 140)




SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -2, 1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.34, -10, 1.25)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
