AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "T-600 Flamethrower"
SWEP.Category 			= "TRP - Drones"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_minigun_2.mdl")
SWEP.WorldModel 		= ""

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "pistol"
SWEP.PassiveHoldType 	= "pistol"

SWEP.Firemodes 			= -1

SWEP.ClipSize 			= -1
SWEP.Delay 				= 60 / 1200

SWEP.Damage 			= 12

SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(30)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.3
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0

SWEP.LoopSound 			= "Phx.HoverHeavy"
SWEP.Tracer 			= "trp_minitracer"
SWEP.AttachmentOverride = "minigun"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(-2, 2, 0)
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
		Ang = Angle(-2, 2, 25)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	if event == 20 or event == 21 then
		return true
	end
end

local models = {
	["models/tnb/player/trp/t600.mdl"] = true,
	["models/tnb/player/trp/t600_skinjob.mdl"] = true,
	["models/tnb/player/trp/t600_skinjob2.mdl"] = true
}

if CLIENT then
	function SWEP:DoDrawCrosshair() end
else
	function SWEP:Deploy()
		BaseClass.Deploy(self)

		local ply = self:GetOwner()

		if IsValid(ply) and models[ply:GetModel()] then
			ply:RecalculatePlayerModel(self)
		end
	end

	function SWEP:Holster(weapon)
		local ok = BaseClass.Holster(self, weapon)

		local ply = self:GetOwner()

		if ok and models[ply:GetModel()] then
			ply:RecalculatePlayerModel(NULL)
		end

		return ok
	end

	function SWEP:OnRemove()
		local ply = self:GetOwner()

		if IsValid(ply) and models[ply:GetModel()] then
			ply:RecalculatePlayerModel(NULL)
		end

		return BaseClass.OnRemove(self)
	end
end

function SWEP:GetModelData(ply, data)
	table.Merge(data, {
		head = {
			bodygroups = {
				rightarm = 1,
				leftarm = 3
			}
		}
	})
end

function SWEP:PrimaryFire()
	local ply = self:GetOwner()

	self:TakePrimaryAmmo(1)

	local delay = self.Delay

	if SERVER then
		local forwardBoost = math.Rand(20, 40)
		local frac = ply:GetEyeTrace().Fraction

		if frac < 0.001245 then
			forwardBoost = 1
		end

		local forward = ply:EyeAngles():Forward()
		local pos = ply:GetShootPos() + forward * forwardBoost
		local vel = forward * math.Rand(1000, 2000)

		CreateVFireBall(math.Rand(4, 8) * 2.15, 20, pos, vel, ply)
	end

	if not self:GetIsFiring() then
		local effectdata = EffectData()
			effectdata:SetAttachment(1)
			effectdata:SetEntity(self)

		util.Effect("cc_e_flamethrower_vfire", effectdata, true, true)
	end

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

	self:SetNextIdle(CurTime() + delay)
	self:SetNextPrimaryFire(CurTime() + delay)

	if self.ShotgunPump then
		self:SetNeedPump(true)
	end
end
