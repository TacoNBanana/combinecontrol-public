AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "APU - Minigun"

SWEP.Category 				= "TRP Exo Weapons"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_minigun_3.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.Damage 				= 30
SWEP.FireDelay 				= 0.06
SWEP.BulletCount 			= 2
SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.06

SWEP.Tracer 				= "trp_minitracer"
SWEP.AttachmentOverride 	= "muzzle_right"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.5

SWEP.AimCone 				= 0.001
SWEP.HipCone 				= 0.045

SWEP.LoopSounds = {
    loop = "tekka/weapons/minigun_predator.wav",
    stop = "tekka/weapons/minigun_winddown.wav"
}

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 8
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "normal"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, -45),
	pos = Vector(-9, 12, 2)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, -45),
	pos = Vector(-9, 12, 3)
}

SWEP.LoweredOffset = {
	ang = Vector(-5, 0, -45),
	pos = Vector(-9, 5, 2)
}

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t700.mdl"] = {1, 1},
	["models/tnb/skynet/t400.mdl"] = {3},
	["models/tnb/skynet/t400_repro.mdl"] = {3}
}

if CLIENT then
	function SWEP:Think()
		self.BaseClass.Think(self)

		if self.Owner:KeyDown(IN_ATTACK) and self:CanFire() then
			ang = Angle(0, 0, -5)
			ang:RotateAroundAxis(Vector(0, 1, 0), CurTime() * 2000)
			ang:RotateAroundAxis(Vector(1, 0, 0), 5)

			self.VM:ManipulateBoneAngles(2, ang)
		end
	end
end