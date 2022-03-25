AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "AEK"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_aek.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_aek.mdl")

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 30
SWEP.Damage 				= 20
SWEP.FireDelay 				= 0.09

SWEP.AmmoItem 				= "ammo_rifle"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 0.8


SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.05

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SHARP", "tekka/weapons/weapon_sharp.wav", 140)




SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, -2),
	pos = Vector(-1, -4, -2)
}

SWEP.AimOffset = {
	ang = Vector(1.9, 0, -2),
	pos = Vector(-4.84, -10, 0)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
