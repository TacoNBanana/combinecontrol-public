AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "M224 Mortar"
SWEP.Category 			= "TRP - Launchers"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_mortar.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_mortar.mdl")

SWEP.UseHands 			= false

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	[1] = "null"
}

SWEP.ActiveHoldType 	= "normal"
SWEP.PassiveHoldType 	= "normal"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_rpg"
SWEP.Durability 		= {10, 20}
SWEP.JamTypes 			= {
	Misfire = 2
}

SWEP.ClipSize 			= -1
SWEP.Delay 				= 2

SWEP.StandingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(10)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.5
SWEP.ZoomLevel 			= 1.5

SWEP.RecoilDiv 			= Vector(3, 2, 8)
SWEP.RecoilKick 		= -5

SWEP.FireSound 			= "Terminator_Mortar.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, -5, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -5, 0),
		Ang = Angle(0, 0, 0)
	},
	Aim = {
		Pos = Vector(0, -2, 6),
		Ang = Angle(10, 0, 0)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_DRAW] = "throw",
	[ACT_VM_IDLE] = "throw"
}

function SWEP:Deploy()
	BaseClass.Deploy(self)

	if CLIENT then
		self:EmitSound("Universal.Draw")
	end
end

function SWEP:CanFire()
	local ok, doSound = BaseClass.CanFire(self)

	if not ok then
		return ok, doSound
	end

	if self:UseAmmo() and not self:HasReserveAmmo() then
		return false, true
	end

	return true
end

local function TargetSolution(target, origin, velocity, gravity, high)
	local elevation = target.z - origin.z
	local distance = Vector(target.x, target.y, 0):Distance(Vector(origin.x, origin.y, 0))

	gravity = -(gravity).z

	if high then
		return math.atan(((velocity ^ 2) * (1 + math.sqrt(1 - (gravity * (gravity * (distance ^ 2) + 2 * (velocity ^ 2) * elevation)) / (velocity ^ 4)))) / (gravity * distance))
	else
		return math.atan(((velocity ^ 2) * (1 - math.sqrt(1 - (gravity * (gravity * (distance ^ 2) + 2 * (velocity ^ 2) * elevation)) / (velocity ^ 4)))) / (gravity * distance))
	end
end

function SWEP:PrimaryFire()
	local ply = self:GetOwner()

	if self:UseAmmo() and SERVER then
		local item = ply:GetFirstItem(self.AmmoType)

		if class.IsTypeOf(item, "base_stacking") then
			item:TakeAmount(1)
		else
			GAMEMODE:DeleteItem(item)
		end
	end

	ply:SetAnimation(PLAYER_ATTACK1)

	local duration = self:DoWeaponAnim(ACT_VM_PRIMARYATTACK)
	local delay = self.Delay == -1 and duration or self.Delay

	local spread = math.deg(self:GetCurrentSpread())

	if SERVER then
		local target = ply:GetEyeTrace().HitPos
		local ang = ply:GetAimVector():Angle() + ply:GetViewPunchAngles() + AngleRand(-spread, spread) - Angle(1, 0, 0)
		local pos = LocalToWorld(Vector(8, -2, -10), angle_zero, ply:GetShootPos(), ang)

		local ent = ents.Create("cc_mortar")

		local pitch = TargetSolution(target, pos, ent.Velocity, physenv.GetGravity() * ent.GravityMultiplier, false)

		if pitch == pitch and self:GetAimFraction() > 0.7 then
			ang.p = math.deg(-pitch) + math.Rand(-spread, spread)
		end

		ent:SetPos(pos)
		ent:SetAngles(ang - Angle(1, 0, 0))
		ent:SetOwner(ply)
		ent:Spawn()
		ent:Activate()
	end

	self:EmitSound(self.FireSound)

	self:ViewKick(ply, self.RecoilKick)
	self:SetLastFire(CurTime())

	self:SetNextIdle(CurTime() + duration)
	self:SetNextPrimaryFire(CurTime() + delay)
end

function SWEP:GetInterpHolster()
	local frac = BaseClass.GetInterpHolster(self)

	return math.Clamp(frac + (1 - self:GetCrouchFraction()), 0, 1)
end

if CLIENT then
	function SWEP:DrawWorldModel()
		local ply = self:GetOwner()

		if self.WorldModel == "" then
			return
		end

		if not IsValid(self.WorldCSEnt) then
			local ok = self:CreateWorldModel()

			if not ok then
				return -- Some weird shit going on
			end
		end

		local ang = ply:GetAngles()

		ang.p = 0
		ang.y = ang.y + 90

		local pos = LocalToWorld(Vector(0, -10, -20), angle_zero, ply:GetPos(), ang)

		self.WorldCSEnt:SetRenderOrigin(pos)

		self.WorldCSEnt:SetRenderAngles(ang)

		self.WorldCSEnt:SetupBones()
		self.WorldCSEnt:DrawModel()
		self.WorldCSEnt:CreateShadow()
	end

	function SWEP:DoDrawCrosshair(x, y)
		x = x - 1
		y = y - 1

		surface.SetDrawColor(255, 255, 255)

		render.OverrideBlend(true, BLEND_ONE_MINUS_DST_COLOR, BLEND_ZERO, BLENDFUNC_ADD)

		if self:GetInterpAim() >= 0.5 and self:GetInterpHolster() <= 0.5 then
			surface.DrawRect(x, y, 2, 2)
		end

		render.OverrideBlend(false)

		return true
	end

	function SWEP:GetHudText()
		local ply = self:GetOwner()
		local ang = ply:EyeAngles() + ply:GetViewPunchAngles()
		local pitch = -ang.p

		local ent = scripted_ents.Get("cc_mortar")
		local ready

		if self:GetAimFraction() > 0.7 then
			local target = ply:GetEyeTrace().HitPos
			local pos = LocalToWorld(Vector(8, 8, -10), angle_zero, ply:GetShootPos(), ang)

			local ok = TargetSolution(target, pos, ent.Velocity, physenv.GetGravity() * ent.GravityMultiplier, false)

			ready = ok == ok and "Ready" or "Out of range"
		end

		return string.format("Pitch: %.2f", pitch), ready
	end
end
