AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "USP .45"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_usp.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_usp.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 12
SWEP.Damage 				= 15
SWEP.FireDelay 				= 0.1

SWEP.AmmoItem 				= "ammo_pistol"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 0.4

SWEP.RecoilAxisMod = {
	side = 1,
	forward = 5,
	up = 0,
	pitch = 0,
	roll = 1
}

SWEP.AimCone 				= 0.03
SWEP.HipCone 				= 0.06

SWEP.FireSound 				= soundscript.AddFire("WEAPON_PISTOLCRACK", "tekka/weapons/weapon_pistolcrack.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2"}
}


SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -8, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.34, -8, 2.6)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
