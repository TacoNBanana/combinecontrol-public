AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Mac10"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_mac10.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_mac10.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 30
SWEP.Damage 				= 15
SWEP.FireDelay 				= 0.06

SWEP.AmmoItem 				= "ammo_pistol"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.7


SWEP.AimCone 				= 0.05
SWEP.HipCone 				= 0.09

SWEP.FireSound 				= soundscript.AddFire("WEAPON_MAC10", "tekka/weapons/weapon_mac10.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2"}
}

SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -7, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 1, 0),
	pos = Vector(-5.3, -9, 1.5)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
