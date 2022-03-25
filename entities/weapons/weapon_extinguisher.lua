AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Fire extinguisher"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/weapons/c_fire_extinguisher.mdl")
SWEP.WorldModel 			= Model("models/weapons/w_fire_extinguisher.mdl")

SWEP.FireDelay 				= 0.05

SWEP.Firemodes 				= {
	{Mode = "firemode_extinguisher"}
}

SWEP.HoldType 				= "slam"
SWEP.HoldTypeLowered 		= "normal"

SWEP.LoopSounds = {
	loop = "weapons/extinguisher/fire1.wav",
	stop = "weapons/extinguisher/release1.wav"
}