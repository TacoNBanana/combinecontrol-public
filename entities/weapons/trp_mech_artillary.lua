AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "APU - Artillary Swarm"

SWEP.Category 				= "TRP Exo Weapons"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_scanner.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= false

SWEP.Firemodes 				= {
	{Mode = FIREMODE_CANNON, Vars = {
		High = 1,
		ClipSize = 12,
		Delay = 0.12,		
		Projectile = "cc_mortarswarm",
		NoBlind = true
	}}
}

SWEP.Recoil 				= 0.5

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_mortar")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 8

	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 5 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 1
	SWEP.RTScopeReticle 			= true
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "normal"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(5, -12, 12)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(5, -13, 8)
}

SWEP.LoweredOffset = {
	ang = Vector(-10, 0, 0),
	pos = Vector(1, -12, -3)
}

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t400.mdl"] = {2},
	["models/tnb/skynet/t400_repro.mdl"] = {2}
}

if CLIENT then
	function SWEP:Think()
		self.BaseClass.Think(self)

		if self.Owner:KeyDown(IN_ATTACK) and self:CanFire() then
			ang = Angle(0, 0, -5)
			ang:RotateAroundAxis(Vector(0, 1, 0), CurTime() * 500)
			ang:RotateAroundAxis(Vector(1, 0, 0), 5)

			self.VM:ManipulateBoneAngles(2, ang)
		end
	end
end