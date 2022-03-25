AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-450 Railgun"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.MuzzleEffect 			= "AR2Explosion"

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_xm.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.Tracer 				= "trp_laser_beam"
SWEP.LaserColor 			= Color(0, 161, 255)
SWEP.DoDissolve 			= true
SWEP.Damage 				= 500

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= false

SWEP.Firemodes 				= {
	{Mode = FIREMODE_RAILGUN, Vars = {}}
}

SWEP.Recoil 				= 2



SWEP.AimCone 				= 0
SWEP.HipCone 				= 0.02

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 14
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2", "shoot3"}
}

SWEP.HoldType 			= "normal"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -11, -2)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -11, -1)
}

SWEP.LoweredOffset = {
	ang = Vector(-10, 0, 0),
	pos = Vector(1, -12, -3)
}

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t400.mdl"] = {1},
	["models/tnb/skynet/t400_repro.mdl"] = {1}
}

function SWEP:SetupDataTables()
	self.BaseClass.SetupDataTables(self)

	self:NetworkVar("Float", 3, "StartFire")
end