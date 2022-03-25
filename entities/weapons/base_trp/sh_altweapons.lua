AddCSLuaFile()

local weaponList = {}

function SWEP:GetAltWeapon()
	return weaponList[self.AltWeapon]
end

function SWEP:ToggleAltWeapon()
	self:SetAltMode(not self:GetAltMode())

	local alt = self:GetAltAmmo()
	local weapon = self:GetAltWeapon()

	self:SetAltAmmo(self:Clip1())
	self:SetClip1(alt)

	self:SetNextPrimaryFire(CurTime() + weapon.SwitchTime)
end

weaponList.M203 = {
	Name = "40mm grenade",
	AmmoType = "ammo_40mm",
	Firemode = 0,
	AutoBurst = 0,
	SwitchTime = 0.6,
	Clip = 1,
	ReloadTime = 3,
	Fire = function(self, tab)
		local ply = self:GetOwner()

		ply:SetAnimation(PLAYER_ATTACK1)

		local duration = self:DoWeaponAnim(ACT_VM_PRIMARYATTACK)

		self:TakePrimaryAmmo(1)

		if SERVER then
			local ang = ply:GetAimVector():Angle() + ply:GetViewPunchAngles()
			local pos = LocalToWorld(Vector(8, -6, -6), angle_zero, ply:GetShootPos(), ang)

			local ent = ents.Create("cc_m203")
			ent:SetPos(pos)
			ent:SetAngles(ang + Angle(-10, 0, 0))
			ent:SetOwner(ply)
			ent:Spawn()
			ent:Activate()
		end

		self:EmitSound("Weapon_SMG1.Double")

		self:ViewKick(ply, 2, 0)

		self:SubtractDurability(unpack(tab.Durability or {}))

		self:SetNextIdle(CurTime() + duration)
		self:SetNextPrimaryFire(CurTime() + 0.1)
	end
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

weaponList.M203_Smoke_Drone = {
	Name = "40mm smoke grenade",
	Firemode = 0,
	AutoBurst = 0,
	SwitchTime = 0.6,
	Clip = -1,
	Fire = function(self, tab)
		local ply = self:GetOwner()

		ply:SetAnimation(PLAYER_ATTACK1)

		local duration = self:DoWeaponAnim(ACT_VM_PRIMARYATTACK)

		if SERVER then
			local ang = ply:GetAimVector():Angle() + ply:GetViewPunchAngles()
			local pos = LocalToWorld(Vector(8, -6, -6), angle_zero, ply:GetShootPos(), ang)

			local ent = ents.Create("cc_m203_smoke")

			local pitch = TargetSolution(ply:GetEyeTrace().HitPos, pos, ent.Velocity, physenv.GetGravity() * ent.GravityMultiplier, false)

			if pitch == pitch and self:GetAimFraction() >= 0.5 then
				ang.p = math.deg(-pitch)
			else
				ang = ang + Angle(-10, 0, 0)
			end

			ent:SetPos(pos)
			ent:SetAngles(ang)
			ent:SetOwner(ply)
			ent:Spawn()
			ent:Activate()
		end

		self:EmitSound("Terminator_M203.Smoke")

		self:ViewKick(ply, 2, 0)

		self:SetNextIdle(CurTime() + duration)
		self:SetNextPrimaryFire(CurTime() + 1)
	end
}

weaponList["20mm"] = {
	Name = "20mm grenade",
	Firemode = 0,
	AutoBurst = 0,
	SwitchTime = 0.6,
	Clip = 5,
	Fire = function(self, tab)
		local ply = self:GetOwner()

		ply:SetAnimation(PLAYER_ATTACK1)

		local duration = self:DoWeaponAnim(ACT_VM_PRIMARYATTACK)

		self:TakePrimaryAmmo(1)

		if SERVER then
			local ang = ply:GetAimVector():Angle() + ply:GetViewPunchAngles()
			local pos = LocalToWorld(Vector(8, -6, -6), angle_zero, ply:GetShootPos(), ang)

			local ent = ents.Create("cc_20mm")
			ent:SetPos(pos)
			ent:SetAngles(ang + Angle(-1, 0, 0))
			ent:SetOwner(ply)
			ent:Spawn()
			ent:Activate()
		end

		self:EmitSound("Terminator_Thud.Fire")

		self:ViewKick(ply, 2, 0)

		self:SetNextIdle(CurTime() + duration)
		self:SetNextPrimaryFire(CurTime() + duration)
	end
}
