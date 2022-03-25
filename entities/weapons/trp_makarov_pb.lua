AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Makarov PB"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_makarov_pb.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_makarov_pb.mdl")

SWEP.UseHands 				= true

SWEP.ClipSize 				= 7
SWEP.FireDelay 				= 0.12

SWEP.AmmoCaliber 			= "9x18mm"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_PISTOLCRACK", "tekka/weapons/weapon_pistolcrack.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_semi", Vars = {}}
}

SWEP.Recoil 				= 0.2

SWEP.AimCone 				= 0.04
SWEP.HipCone 				= 0.07

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
	ang = Vector(0, 0, 0),
	pos = Vector(-6.4, -4, 2.945)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
