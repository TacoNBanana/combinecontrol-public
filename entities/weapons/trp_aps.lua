AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "APS"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_aps.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_aps.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.ClipSize 				= 20
SWEP.FireDelay 				= 0.13

SWEP.AmmoCaliber 			= "9x18mm"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_PISTOLCRACK", "tekka/weapons/weapon_pistolcrack.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_semi"},
	{Mode = "firemode_auto"}
}

SWEP.Recoil 				= 0.5

SWEP.AimCone 				= 0.03
SWEP.HipCone 				= 0.05

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"


SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -8, 1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0.801, 0),
	pos = Vector(-6.25, -10, 2.6)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
