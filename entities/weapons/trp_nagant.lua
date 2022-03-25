AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Nagant Revolver"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_nagant.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_nagant.mdl")

SWEP.UseHands 				= true

SWEP.ClipSize 				= 6
SWEP.FireDelay 				= 0.4

SWEP.AmmoCaliber 			= "7.62x25mm"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_PISTOLSMALL", "tekka/weapons/weapon_pistolsmall.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_semi"}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0.04
SWEP.HipCone 				= 0.07

SWEP.Animations = {
	reload = "reload",
	fire = "fire"
}

SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -7, -1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-4.599, -7, 0.7)
}

SWEP.LoweredOffset = {
	ang = Vector(-25, 0, 0),
	pos = Vector(0, 0, 3)
}
