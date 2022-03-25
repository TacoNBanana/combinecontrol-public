AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Uzi Mini"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_uzi.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_uzi.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {3}
SWEP.WMBodyGroups 			= {3}

SWEP.ClipSize 				= 30
SWEP.FireDelay 				= 0.1

SWEP.AmmoCaliber 			= "9x19mm"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_PISTOLCRACK", "tekka/weapons/weapon_pistolcrack.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_auto"}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0.04
SWEP.HipCone 				= 0.07

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2"}
}

SWEP.HoldType 			= "pistol"
SWEP.HoldTypeLowered 	= "normal"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -5, -1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.349, -5, 1.201)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
