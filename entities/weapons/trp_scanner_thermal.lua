AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Thermal Imaging Device"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_scanner.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_scanner.mdl")

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.UseHands 				= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_BINOC, Vars = {}}
}

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeAlwaysOn 			= true
	SWEP.RTScopeFOV 				= 8 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 1
	SWEP.RTScopeReticle 			= true
end


SWEP.Animations = {
	reload = "reload",
	fire = {"shoot"}
}

SWEP.HoldType 			= "camera"
SWEP.HoldTypeLowered 	= "normal"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(5, -7, 1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1.5, -13, 6.257)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}