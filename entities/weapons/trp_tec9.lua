AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Tec9"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_tec9.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_tec9.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.ClipSize 				= 20
SWEP.FireDelay 				= 0.11

SWEP.AmmoCaliber 			= "9x19mm"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_PISTOLCRACK", "tekka/weapons/weapon_pistolcrack.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_semi"},
	{Mode = "firemode_auto"}
}

SWEP.Recoil 				= 1.1

SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.05

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2"}
}

SWEP.HoldType 			= "pistol"
SWEP.HoldTypeLowered 	= "normal"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -6, 1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.4, -7, 2.3)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
