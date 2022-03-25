AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "MP40"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_mp40.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_mp40.mdl")

SWEP.UseHands 				= true


SWEP.ClipSize 				= 30
SWEP.FireDelay 				= 0.12

SWEP.AmmoCaliber 			= "9x19mm"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_PISTOLCRACK", "tekka/weapons/weapon_pistolcrack.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_auto"},
	{Mode = "firemode_semi"}
}

SWEP.Recoil 				= 1.4

SWEP.AimCone 				= 0.03
SWEP.HipCone 				= 0.05

SWEP.Animations = {
	reload = "reload1",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -6, 1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.32, -7, 3.1)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
