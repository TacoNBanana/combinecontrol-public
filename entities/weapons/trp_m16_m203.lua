AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "M16 M203"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_m16.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_m16.mdl")

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

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
	{Mode = FIREMODE_SEMI, Vars = {}},
	{Mode = FIREMODE_M203, Vars = {}},
	{Mode = FIREMODE_M203, Vars = {
		Name = "M203 Smoke",
		AmmoPool = "M203_SMOKE",
		AmmoItem = "ammo_m203_smoke",
		Projectile = "cc_m203_smoke"
	}}
}

SWEP.Recoil 				= 0.5

SWEP.RecoilAxisMod = {
	side = 1,
	forward = 5,
	up = 0,
	pitch = 0,
	roll = 1
}

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.05

SWEP.FireSound 				= soundscript.AddFire("WEAPON_M4", "tekka/weapons/weapon_aks.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.51, -6, 1.15)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
