AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "T-450 Plasma Cannon"
SWEP.Category 			= "TRP - Drones"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_minigun_3.mdl")
SWEP.WorldModel 		= ""

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.Firemodes 			= -1

SWEP.ClipSize 			= -1
SWEP.Delay 				= 1

SWEP.Plasma 			= true
SWEP.Damage 			= 100

SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(30)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.3
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilDiv 			= Vector(3, 2, 8)
SWEP.RecoilKick 		= 1

SWEP.FireSound 			= "Terminator_Turret.Secondary"
SWEP.Tracer 			= "trp_laser_beam"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, 3, -5),
		Ang = Angle(0, -15, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, -5),
		Ang = Angle(0, 0, 0)
	},
	Aim = {
		Pos = Vector(0, -3, 7),
		Ang = Angle(-2, 0, 25)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	if event == 20 or event == 5001 then
		return true
	end
end

function SWEP:PrimaryFire()
	local ply = self:GetOwner()

	self:TakePrimaryAmmo(1)

	ply:SetAnimation(PLAYER_ATTACK1)

	local duration = self:DoWeaponAnim(ACT_VM_PRIMARYATTACK)
	local delay = self.Delay == -1 and duration or self.Delay

	local spread = self:GetCurrentSpread()
	local bullet = {}

	bullet.Attacker 	= ply
	bullet.Num 			= self.BulletCount
	bullet.Src 			= ply:GetShootPos()
	bullet.Dir 			= (ply:GetAimVector():Angle() + ply:GetViewPunchAngles()):Forward()
	bullet.Spread 		= Vector(spread, spread, 0)
	bullet.Damage 		= self.Damage / self.BulletCount
	bullet.TracerName 	= self.Tracer
	bullet.Force 		= self.Damage * 0.3
	bullet.Callback 	= function(attacker, tr, damageinfo)
		if SERVER and not tr.HitSky then
			local ent = ents.Create("env_explosion")

			ent:SetPos(tr.HitPos)
			ent:SetAngles(tr.HitNormal:Angle())
			ent:SetOwner(ply)

			ent:SetKeyValue("spawnflags", 48)
			ent:SetKeyValue("iMagnitude", 60)

			ent:Spawn()
			ent:Activate()
			ent:Fire("Explode")
		end
	end

	if self.Plasma then
		GAMEMODE.PlasmaBullet = true
	end

	GAMEMODE.ShotgunDamage = self.Damage / self.BulletCount

	self:FireBullets(bullet)

	GAMEMODE.ShotgunDamage = nil
	GAMEMODE.PlasmaBullet = nil

	if self.LoopSound then
		if IsFirstTimePredicted() and not self:GetIsFiring() then
			self.SoundID = self:StartLoopingSound(self.LoopSound)
		end
	else
		self:EmitSound(self.FireSound)
	end

	self:SetIsFiring(true)

	self:ViewKick(ply, self.RecoilKick)
	self:SetLastFire(CurTime())

	self:SubtractDurability(unpack(self.Durability or {}))

	self:SetNextIdle(CurTime() + duration)
	self:SetNextPrimaryFire(CurTime() + delay)

	if self.Primary.Automatic and self:ConditionProb(self.JamTypes.Sear) then
		self:EmitSound("Terminator_Weapon.Jam")
		self:SetSearFailed(true)
	end

	if self:ConditionProb(self.JamTypes.Malfunction) then
		self:EmitSound("Terminator_Weapon.Jam")
		self:SetMalfunction(true)

		if SERVER then
			ply:SendChat(nil, "WARNING", "Your weapon is jammed!")
		end
	end

	if self.ShotgunPump then
		self:SetNeedPump(true)
	end
end
