AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "M202 Rocket Launcher"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_m202.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_m202.mdl")

SWEP.ClipSize 				= 4
SWEP.Damage 				= 500
SWEP.FireDelay 				= 0.8

SWEP.AmmoItem 				= "ammo_rpg"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_RPG, Vars = {ClipSize = 4}}
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

SWEP.FireSound 				= soundscript.AddFire("TRP_RPG", "tekka/weapons/weapon_launcher.wav", 140)

SWEP.HoldType 				= "rpg"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 3)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -4, 2)
}

SWEP.LoweredOffset = {
	ang = Vector(-20, 10, 10),
	pos = Vector(0, 0, 5)
}