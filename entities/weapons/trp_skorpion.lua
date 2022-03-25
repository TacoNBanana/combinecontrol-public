AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Skorpion"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_skorpion.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_skorpion.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 30
SWEP.Damage 				= 15
SWEP.FireDelay 				= 0.07

SWEP.AmmoItem 				= "ammo_pistol"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.3


SWEP.AimCone 				= 0.03
SWEP.HipCone 				= 0.06

SWEP.FireSound 				= soundscript.AddFire("WEAPON_MAC10", "tekka/weapons/weapon_mac10.wav", 140)

SWEP.Animations = {
	reload = "reload1",
	fire = {"shoot1", "shoot2"}
}


SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -5, 1)
}

SWEP.AimOffset = {
	ang = Vector(2, 0, 0),
	pos = Vector(-5.25, -9, 3)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
