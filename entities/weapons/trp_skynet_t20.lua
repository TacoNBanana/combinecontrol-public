AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-20"

SWEP.Category 				= "TRP Skynet"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_minigun_3.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.Damage 				= 20
SWEP.FireDelay 				= 0.12

SWEP.Tracer 				= "trp_minitracer"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_CANNON, Vars = {
		Name = "M203 Smoke",
		ClipSize = -1,
		Projectile = "cc_m203_smoke"
	}}
}

SWEP.Recoil 				= 0.1

SWEP.AimCone 				= 0.005
SWEP.HipCone 				= 0.045

SWEP.FireSound 				= soundscript.AddFire("TEKKA_THUDSOFT", "tekka/weapons/weapon_thudsoft.wav", 100)

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 8
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot", "shoot2"}
}

SWEP.HoldType 			= "normal"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

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

if CLIENT then
	function SWEP:Think()
		self.BaseClass.Think(self)

		if self.Owner:KeyDown(IN_ATTACK) and self:CanFire() and self.Primary.Automatic then
			ang = Angle(0, 0, -5)
			ang:RotateAroundAxis(Vector(0, 1, 0), CurTime() * 2000)
			ang:RotateAroundAxis(Vector(1, 0, 0), 5)

			self.VM:ManipulateBoneAngles(2, ang)
		end
	end
end