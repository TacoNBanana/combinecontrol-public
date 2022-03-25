AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "China Lake"
SWEP.Category 			= "TRP - Launchers"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/arccw/c_bo1_chinalake.mdl")
SWEP.WorldModel 		= Model("models/weapons/arccw/c_bo1_chinalake.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "shotgun_ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_40mm"
SWEP.Durability 		= {30, 40}
SWEP.JamTypes 			= {
	Misfire = 2
}

SWEP.ClipSize 			= 3
SWEP.Delay 				= -1

SWEP.CrouchingAccuracy 	= {util.RangeMeters(25, 64), util.RangeMeters(200, 64)}
SWEP.StandingAccuracy 	= {util.RangeMeters(20, 64), util.RangeMeters(100, 64)}

SWEP.AimTime 			= 0.5
SWEP.ZoomLevel 			= 1.5

SWEP.ShotgunReload 		= true
SWEP.ShotgunPump 		= true

SWEP.RecoilKick 		= 4

SWEP.FireSound 			= "ArcCW_BO1.M203_Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -3, -3),
		Ang = Angle(0, 40, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, -3),
		Ang = Angle(5, 15, 0)
	},
	Aim = {
		Pos = Vector(-2, 0, 1),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_IDLE] = "idle",
	[ACT_VM_PRIMARYATTACK] = "fire",
	[ACT_SHOTGUN_RELOAD_START] = "reload_in",
	[ACT_VM_RELOAD] = "reload_loop",
	[ACT_SHOTGUN_RELOAD_FINISH] = "reload_out",
	[ACT_SHOTGUN_PUMP] = "pump"
}

SWEP.FixWorldModel 		= {
	ang = Angle(0, -9, 180),
	pos = Vector(1, 4, -7),
	scale = 1
}

if CLIENT then
	function SWEP:DoSoundUpdate(sequence, last, time)
		if sequence == "pump" then
			if math.InRange(26 / 35, last, time) then self:EmitSound("ArcCW_BO1.MK_Back") end
			if math.InRange(38 / 35, last, time) then self:EmitSound("ArcCW_BO1.MK_Fwd") end
		elseif sequence == "reload_in" then
			if math.InRange(5 / 35, last, time) then self:EmitSound("ArcCW_BO1.MK_Back") end
		elseif sequence == "reload_loop" then
			if math.InRange(29 / 35, last, time) then self:EmitSound("ArcCW_BO1.MK_Shell") end
		elseif sequence == "reload_out" then
			if math.InRange(21 / 35, last, time) then self:EmitSound("ArcCW_BO1.MK_Fwd") end
		end
	end
end

function SWEP:FireAnimationEvent(_, _, event)
	return true
end

function SWEP:Deploy()
	BaseClass.Deploy(self)

	if CLIENT then
		self:EmitSound("Universal.Draw")
	end
end

function SWEP:PrimaryFire()
	local ply = self:GetOwner()

	self:TakePrimaryAmmo(1)

	ply:SetAnimation(PLAYER_ATTACK1)

	local duration = self:DoWeaponAnim(ACT_VM_PRIMARYATTACK)
	local delay = self.Delay == -1 and duration or self.Delay

	local spread = math.deg(self:GetCurrentSpread())

	if SERVER then
		local ang = ply:GetAimVector():Angle() + ply:GetViewPunchAngles() + AngleRand(-spread, spread)
		local pos = LocalToWorld(Vector(8, -6, -6), angle_zero, ply:GetShootPos(), ang)

		local ent = ents.Create("cc_m203")
		ent:SetPos(pos)
		ent:SetAngles(ang + Angle(-10, 0, 0))
		ent:SetOwner(ply)
		ent:Spawn()
		ent:Activate()
	end

	self:EmitSound(self.FireSound)

	self:ViewKick(ply, self.RecoilKick)
	self:SetLastFire(CurTime())

	self:SubtractDurability(unpack(self.Durability or {}))

	self:SetNextIdle(CurTime() + duration)
	self:SetNextPrimaryFire(CurTime() + delay)

	if self.ShotgunPump then
		self:SetNeedPump(true)
	end
end

function SWEP:DrawWorldModel()
	self:ManipulateBoneScale(90, Vector(0, 0, 0), true)

	BaseClass.DrawWorldModel(self)
end
