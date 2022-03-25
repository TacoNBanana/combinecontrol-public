AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Prototype Railgun"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.MuzzleEffect 			= "cball_explode"

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_xm.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_xm.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser_beam"
SWEP.LaserColor 			= Color(0, 161, 255)

SWEP.ClipSize 				= 5
SWEP.Damage 				= 500

SWEP.AmmoItem 				= "ammo_plasma_heavy"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_RAILGUN, Vars = {}}
}

SWEP.Recoil 				= 3

SWEP.AimCone 				= 0
SWEP.HipCone 				= 0.02

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 8
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2", "shoot3"}
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

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
	ang = Vector(-10, 10, 0),
	pos = Vector(-3, -11, -3)
}

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t400.mdl"] = {1},
	["models/tnb/skynet/t400_repro.mdl"] = {1}
}

function SWEP:SetupDataTables()
	self.BaseClass.SetupDataTables(self)

	self:NetworkVar("Float", 3, "StartFire")
end