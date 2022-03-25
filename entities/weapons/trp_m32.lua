AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "M32"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModelFlip 			= true
SWEP.ViewModel 				= Model("models/tnb/weapons/c_m32.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_m32.mdl")

SWEP.ClipSize 				= 6
SWEP.Damage 				= 500
SWEP.FireDelay 				= -1

SWEP.UseHands 				= false

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_M203, Vars = {
		ClipSize = 6
	}},
	{Mode = FIREMODE_M203, Vars = {
		ClipSize = 6,
		Name = "M203 Smoke",
		AmmoPool = "M203_SMOKE",
		AmmoItem = "ammo_m203_smoke",
		Projectile = "cc_m203_smoke"
	}}
}

SWEP.Recoil 				= 1

SWEP.AmmoItem 				= ""
SWEP.ShotgunReload 			= true

SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.035

SWEP.FireSound 				= soundscript.AddFire("TRP_RPG", "tekka/weapons/weapon_launcher.wav", 140)

SWEP.HoldType 				= "ar2"
SWEP.HoldTypeLowered 		= "passive"

SWEP.Animations = {
	fire = {"shoot1", "shoot2"},
	reload = "start_reload",
	reloadfinish = "after_reload",
	reloadinsert = "insert"
}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -2, 1)
}

SWEP.AimOffset = {
	ang = Vector(8.045, 11.446, -1.571),
	pos = Vector(6.697, -3.355, -1.073)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 0, 0),
	pos = Vector(0, 4, 2)
}