AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "G36C"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_g36c.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_g36c.mdl")

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 30
SWEP.Damage 				= 20
SWEP.FireDelay 				= 0.085

SWEP.AmmoItem 				= "ammo_rifle"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 0.8


SWEP.AimCone 				= 0.03
SWEP.HipCone 				= 0.07

SWEP.FireSound 				= soundscript.AddFire("WEAPON_USP", "tekka/weapons/weapon_usp.wav", 140)


SWEP.Animations = {
	reload = "reload",
	fire = {"shoot", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -8, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-7.28, -12, 1.971)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
