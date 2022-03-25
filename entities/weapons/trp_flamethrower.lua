AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Flamethrower"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_airgun.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_airgun.mdl")

SWEP.Firemodes 				= {
	{Mode = "firemode_flamethrower"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.FireDelay 			= 0.07

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -3, 0)
}

SWEP.AimOffset = {
	ang = Vector(1.3, 0, 0),
	pos = Vector(-6.15, -4, 1.4)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

function SWEP:OnRemove()
	self:StopSound("Phx.HoverHeavy")
end

SWEP.LoopSounds = {
	loop = "Phx.HoverHeavy",
}