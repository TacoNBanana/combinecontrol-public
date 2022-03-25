AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "M4 Beowulf"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_m4.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_m4.mdl")

SWEP.VMBodyGroups 			= {5}
SWEP.WMBodyGroups 			= {5}

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 30
SWEP.Damage 				= 40
SWEP.FireDelay 				= 0.08

SWEP.AmmoItem 				= "ammo_rifle"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 0.9



SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.03

SWEP.FireSound 				= soundscript.AddFire("WEAPON_INTERVENTION", "tekka/weapons/weapon_intervention.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -5, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.5, -7, 1.451)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
