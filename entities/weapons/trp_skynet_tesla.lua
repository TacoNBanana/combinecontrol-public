AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "SkyNet Tesla Rifle"

SWEP.Category 				= "TRP Skynet"
SWEP.DrawCrosshair 			= true
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_arc.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_arc.mdl")

SWEP.UseHands 				= true

SWEP.Damage 				= 100

SWEP.AmmoItem 				= false

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_TESLA, Vars = {}}
}

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 8
end

SWEP.Recoil 				= 0

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.02

SWEP.LoopSounds = {
	loop = "ambient/energy/electric_loop.wav",
	stop = "ambient/energy/spark4.wav"
}

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2", "shoot3"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(2, -5, -5)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(2, -8, -4)
}

SWEP.LoweredOffset = {
	ang = Vector(-10, 15, 0),
	pos = Vector(0, -5, -5)
}

function SWEP:SetupDataTables()
	self.BaseClass.SetupDataTables(self)

	self:NetworkVar("Float", 3, "StartFire")
end

function SWEP:FireBullet()
	local ply = self.Owner
	local cone = self.CurrentCone

	math.randomseed(ply:GetCurrentCommand():CommandNumber())

	local aimcone = Angle(math.Rand(-cone, cone), math.Rand(-cone, cone), 0)
	local bullet = {}

	bullet.Num 			= 1
	bullet.Src 			= ply:GetShootPos()
	bullet.Dir 			= (ply:GetAimVector():Angle() + ply:GetViewPunchAngles() + aimcone * 25):Forward()
	bullet.Spread 		= Vector(clump, clump, 0)
	bullet.Damage 		= self.Damage
	bullet.Tracer 		= 1
	bullet.TracerName 	= "cc_e_tesla"
	bullet.Force 		= self.Damage * 0.3
	bullet.AmmoType 	= ""
	bullet.Distance 	= 400

	bullet.Callback 	= function(attacker, tr, dmg)
		local ent = tr.Entity

		if IsValid(ent) then
			if ent:IsPlayer() then
				dmg:SetDamage(0)

				if SERVER then
					ent:SetConsciousness(0)
					ent:PassOut()
				end
			elseif ent:GetClass() == "prop_ragdoll" and IsValid(ent:PropFakePlayer()) then
				dmg:SetDamage(0)

				if SERVER then
					ent:PropFakePlayer():SetConsciousness(0)
				end
			end
		end

		local ed = EffectData()

		ed:SetOrigin(tr.HitPos)
		ed:SetNormal(tr.HitNormal)
		ed:SetEntity(tr.Entity)

		util.Effect("ElectricSpark", ed)

		dmg:SetDamageType(DMG_SHOCK)
	end

	ply:FireBullets(bullet)
end

function SWEP:DoImpactEffect()
	return true
end

function SWEP:FireAnimationEvent(pos, ang, event, name)
	return true
end