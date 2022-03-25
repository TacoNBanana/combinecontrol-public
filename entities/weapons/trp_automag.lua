AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Automag"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_automag.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_automag.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 8
SWEP.Damage 				= 50
SWEP.FireDelay 				= 0.1

SWEP.AmmoItem 				= "ammo_pistol"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 0.2



SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.06

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SHOTGUN2", "tekka/weapons/weapon_shotgun2.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2"}
}


SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2.75, -5, 0.601)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
