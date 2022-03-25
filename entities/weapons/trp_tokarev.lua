AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Tokarev"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_tokarev.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_tokarev.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 7
SWEP.Damage 				= 15
SWEP.FireDelay 				= 0.11

SWEP.AmmoItem 				= "ammo_pistol"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 1



SWEP.AimCone 				= 0.03
SWEP.HipCone 				= 0.06

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SOCOM", "tekka/weapons/weapon_socom.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -7, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 1.3, 0),
	pos = Vector(-6.199, -9, 2.701)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
