AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "RPG-7"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_rpg7.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_rpg7.mdl")

SWEP.ClipSize 				= 1
SWEP.Damage 				= 500
SWEP.FireDelay 				= -1

SWEP.AmmoItem 				= "ammo_rpg"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_RPG, Vars = {}}
}

SWEP.Recoil 				= 1
SWEP.VMRecoilMod 			= 5

SWEP.RecoilAxisMod 			= {
	side = 1,
	forward = 1,
	up = 0,
	pitch = 0,
	roll = 1
}

SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.035

SWEP.FireSound 				= soundscript.AddFire("TRP_RPG", "tekka/weapons/weapon_rpg.wav", 140)

SWEP.HoldType 				= "rpg"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(1, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1.5, -5, 2)
}

SWEP.LoweredOffset = {
	ang = Vector(-20, 0, 0),
	pos = Vector(0, 0, 3)
}