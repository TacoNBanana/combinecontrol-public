AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Ithaca Sawnoff"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_ithaca.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_ithaca.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

SWEP.ClipSize 				= 4
SWEP.FireDelay 				= 0.13

SWEP.AmmoCaliber 			= "ammo_12ga"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SHOTGUN", "tekka/weapons/weapon_shotgun.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_semi"}
}

SWEP.Recoil 				= 2

SWEP.AimCone 				= 0.001
SWEP.HipCone 				= 0.02

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -6, 1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-7.9, -4, 3)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
