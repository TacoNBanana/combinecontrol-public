AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "T-450 Howitzer"
SWEP.Category 			= "TRP - Drones"

SWEP.SlotPos 			= 11

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_tc_rocketlauncher.mdl")
SWEP.WorldModel 		= ""

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	[1] = "null"
}

SWEP.Firemodes 			= 0

SWEP.ClipSize 			= -1
SWEP.Delay 				= 1

SWEP.StandingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(10)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.3
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 2

SWEP.FireSound 			= "Terminator_Mortar.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -5),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, 0, -2),
		Ang = Angle(10, 15, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, -2),
		Ang = Angle(10, 15, 0)
	},
	Aim = {
		Pos = Vector(0, 0, -2),
		Ang = Angle(0, 0, 0)
	}
}

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

	self:TakePrimaryAmmo(1)

	ply:SetAnimation(PLAYER_ATTACK1)

	local duration = self:DoWeaponAnim(ACT_VM_PRIMARYATTACK)
	local delay = self.Delay == -1 and duration or self.Delay

	local spread = math.deg(self:GetCurrentSpread())

	if SERVER then
		local target = ply:GetEyeTrace().HitPos
		local ang = ply:GetAimVector():Angle() + ply:GetViewPunchAngles() + AngleRand(-spread, spread) - Angle(1, 0, 0)
		local pos = LocalToWorld(Vector(8, -8, -10), angle_zero, ply:GetShootPos(), ang)

		local ent = ents.Create("cc_cannon")

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

if CLIENT then
	function SWEP:DoDrawCrosshair(x, y)
		x = x - 1
		y = y - 1

		surface.SetDrawColor(255, 255, 255)

		render.OverrideBlend(true, BLEND_ONE_MINUS_DST_COLOR, BLEND_ZERO, BLENDFUNC_ADD)

		if self:GetInterpAim() >= 0.5 then
			surface.DrawRect(x, y, 2, 2)
		end

		render.OverrideBlend(false)

		return true
	end

	function SWEP:GetHudText()
		local ply = self:GetOwner()
		local ang = ply:EyeAngles()
		local pitch = -ang.p

		local ent = scripted_ents.Get("cc_cannon")
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
