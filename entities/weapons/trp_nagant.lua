AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Nagant Revolver"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_nagant.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_nagant.mdl")

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 5
SWEP.Damage 				= 30
SWEP.FireDelay 				= 0.4

SWEP.AmmoItem 				= "ammo_pistol"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 2



SWEP.AimCone 				= 0.05
SWEP.HipCone 				= 0.08

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SOCOM", "tekka/weapons/weapon_socom.wav", 140)


SWEP.Animations = {
	reload = "reload",
	fire = "fire"
}

SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(-1.5, 0, 0),
	pos = Vector(-4.545, -3.5, 0.8)
}

SWEP.LoweredOffset = {
	ang = Vector(-25, 0, 0),
	pos = Vector(0, 0, 3)
}