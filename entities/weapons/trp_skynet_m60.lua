AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-600 M60"

SWEP.Category 				= "TRP Skynet"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_m60.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_m60.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.Damage 				= 30
SWEP.FireDelay 				= 0.1

SWEP.AmmoItem 				= "ammo_lmg"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= false

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.5


SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.06

SWEP.FireSound 				= soundscript.AddFire("WEAPON_CHUG", "tekka/weapons/weapon_chug.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "duel"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.5, -7, 0.801)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t800.mdl"] = {1, 0},
	["models/tnb/skynet/t700.mdl"] = {1, 0},
	["models/tnb/skynet/t700_repro.mdl"] = {1, 0},
	["models/tnb/skynet/t600.mdl"] = {2, 0},
	["models/tnb/skynet/t600_skinjob.mdl"] = {3, 0},
	["models/tnb/skynet/t600_repro.mdl"] = {2, 0}
}