AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "RPK"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_akm.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_akm.mdl")

SWEP.VMBodyGroups 			= {2}
SWEP.WMBodyGroups 			= {2}

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 60
SWEP.Damage 				= 30
SWEP.FireDelay 				= 0.1

SWEP.AmmoItem 				= "ammo_lmg"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 1

SWEP.RecoilAxisMod = {
	side = 1,
	forward = 5,
	up = 0,
	pitch = 0,
	roll = 1
}

SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.06

SWEP.FireSound 				= soundscript.AddFire("WEAPON_M1", "tekka/weapons/weapon_m1.wav", 140)

SWEP.Animations = {
	reload = "ak47_reload",
	fire = {"ak47_fire1", "ak47_fire2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -8, 1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.579, -12, 3)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
