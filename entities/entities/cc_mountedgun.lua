AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Type = "anim"

ENT.PrintName		= ""
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.Spawnable			= false
ENT.AdminSpawnable		= false

ENT.AutomaticFrameAdvance	= true

function ENT:PostEntityPaste(ply, ent, tab)
	GAMEMODE:LogSecurity(ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!")
	ent:Remove()
end

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Player")
end

function ENT:Initialize()
	if CLIENT then return end

	self:SetModel(Model("models/props_combine/bunker_gun01.mdl"))
	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_NONE)
	self:SetUseType(SIMPLE_USE)
end

function ENT:GetAimData()
	local pos, ang = self:GetPlayer():EyePos(), self:GetPlayer():EyeAngles()

	local trace = {}
		trace.start = pos
		trace.endpos = pos + ang:Forward() * 8192
		trace.filter = {self, self:GetPlayer()}
		trace.mask = MASK_BLOCKLOS_AND_NPCS

	return util.TraceLine(trace).HitPos, self:GetAttachment(self:LookupAttachment("muzzle")).Pos
end

function ENT:Aim(target, gun)
	local pitch = 0
	local yaw = 0

	local rad2deg = 180 / math.pi

	local pos, _ = WorldToLocal(target, self:GetAngles(), gun, self:GetAngles())
	local len = pos:Length()

	if len < 0.0000001000000 then
		pitch = 0
	else
		pitch = rad2deg * math.asin(pos.z / len)
	end

	yaw = rad2deg * math.atan2(pos.y, pos.x)

	return -pitch + 10, yaw
end

function ENT:FireBullet()
	local attach = self:GetAttachment(self:LookupAttachment("muzzle"))

	local bullet = {}
	bullet.Num = 1
	bullet.Src = attach.Pos
	bullet.Dir = attach.Ang:Forward()
	bullet.Spread = Vector(math.Rand(0.0112, 0.016), math.Rand(0.0112, 0.016), 0)
	bullet.Tracer = 1
	bullet.TracerName = "AR2Tracer"
	bullet.Force = 10
	bullet.Damage = 25

	self:FireBullets(bullet)
	self:ResetSequence(self:LookupSequence("fire"))
end

function ENT:Think()

	if self:GetPlayer() and self:GetPlayer():IsValid() then

		if self:GetPlayer():GetPos():Distance(self:GetPos()) > 80 or not self:GetPlayer():Alive() then

			self:GetPlayer():SetMountedGun(NULL)
			self:SetPlayer(NULL)
			return

		end

		if SERVER then
			local aimPitch, aimYaw = self:Aim(self:GetAimData())

			aimPitch = math.Approach(self:GetPoseParameter("aim_pitch"), aimPitch, 50 * FrameTime())
			aimYaw = math.Approach(self:GetPoseParameter("aim_yaw"), aimYaw, 50 * FrameTime())

			self:SetPoseParameter("aim_pitch", math.Clamp(aimPitch, -35, 50))
			self:SetPoseParameter("aim_yaw", math.Clamp(aimYaw, -60, 60))
		end

		if self:GetPlayer():KeyDown(IN_ATTACK) then
			if not self.nextFire then
				self.nextFire = 0
			end

			if CurTime() >= self.nextFire then
				self:FireBullet()

				self:EmitSound("Weapon_functank.Single")
				self.nextFire = CurTime() + 0.066
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Use(ply)
	if SERVER then

		if self:GetPlayer() and self:GetPlayer():IsValid() then
			self:GetPlayer():SetMountedGun(NULL)
			self:SetPlayer(NULL)

			self:ResetSequence(self:LookupSequence("retract"))
		else
			for _, v in pairs(GAMEMODE.HandsWeapons) do
				if ply:HasWeapon(v) then
					ply:SelectWeapon(v)

					break
				end
			end

			ply:SetHolstered(true)

			ply:SetMountedGun(self)
			self:SetPlayer(ply)

			self:EmitSound("Func_Tank.BeginUse")
			self:ResetSequence(self:LookupSequence("activate"))
		end
	end
end

function ENT:CanPhysgun()
	return false
end

function ENT:Draw()
	self:DrawModel()
end
