AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "M79"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_m79.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_m79.mdl")

SWEP.ClipSize 				= 1
SWEP.Damage 				= 500
SWEP.FireDelay 				= -1

SWEP.UseHands 				= true

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_M203, Vars = {}},
	{Mode = FIREMODE_M203, Vars = {
		Name = "M203 Smoke",
		AmmoPool = "M203_SMOKE",
		AmmoItem = "ammo_m203_smoke",
		Projectile = "cc_m203_smoke"
	}}
}

SWEP.Recoil 				= 1

SWEP.AmmoItem 				= "ammo_m203"
SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.035

SWEP.FireSound 				= soundscript.AddFire("TRP_RPG", "tekka/weapons/weapon_launcher.wav", 140)

SWEP.HoldType 				= "shotgun"
SWEP.HoldTypeLowered 		= "passive"

SWEP.Animations = {
	fire = {"shoot1", "shoot2"},
	reload = "reload",
}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -6, 2)
}

SWEP.AimOffset = {
	ang = Vector(8, 0, 0),
	pos = Vector(-5.9, -10, 0)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 0, 0),
	pos = Vector(0, 4, 2)
}