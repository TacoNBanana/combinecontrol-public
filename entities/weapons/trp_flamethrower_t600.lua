AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-600 Flamethrower"

SWEP.Category 				= "TRP Skynet"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_t600_m203.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.Firemodes 				= {
	{Mode = FIREMODE_FLAMETHROWER, Vars = {}}
}

SWEP.HoldType 				= "duel"
SWEP.HoldTypeLowered 		= "slam"

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t600.mdl"] = {2, 1},
	["models/tnb/skynet/t600_skinjob.mdl"] = {5, 1},
	["models/tnb/skynet/t600_repro.mdl"] = {2, 1}
}

SWEP.DefaultOffset = {
	ang = Vector(0, 2.5, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2.687, 0, 4.158)
}

SWEP.LoweredOffset = {
	ang = Vector(-10, 0, 0),
	pos = Vector(0, 0, 0)
}

function SWEP:OnRemove()
	self:StopSound("Phx.HoverHeavy")
end

SWEP.LoopSounds = {
	loop = "Phx.HoverHeavy",
}