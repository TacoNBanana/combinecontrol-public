AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Flamethrower"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_scrap.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_scrap.mdl")

SWEP.Firemodes 				= {
	{Mode = FIREMODE_FLAMETHROWER, Vars = {}}
}

SWEP.HoldType 			= "physgun"
SWEP.HoldTypeLowered 	= "physgun"


SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, 3, -2)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-7.599, -2, -2.65)
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