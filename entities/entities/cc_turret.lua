AddCSLuaFile()
DEFINE_BASECLASS("cc_worldent")

ENT.Base 			= "cc_worldent"
ENT.RenderGroup 	= RENDERGROUP_BOTH

ENT.PrintName 		= "SkyNET turret"
ENT.Category 		= "CombineControl - World"

ENT.Spawnable 		= true
ENT.AdminSpawnable 	= true

ENT.Model 			= Model("models/skynet/skynet_turret_2x.mdl")

ENT.MaxHealth 		= 800

game.AddParticles("particles/grenade_fx.pcf")

PrecacheParticleSystem("grenade_explosion_01")

function ENT:SpawnFunction(ply, tr, classname)
	local ent = BaseClass.SpawnFunction(self, ply, tr, classname)

	ent:SetPos(tr.HitPos)

	return ent
end

function ENT:Initialize()
	self:SetModel(self.Model)

	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetUseType(SIMPLE_USE)

		self:SetMaxHealth(self.MaxHealth)
	end

	self:SetHealth(self.MaxHealth)
end

function ENT:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Entity", 0, "Player")

	self:NetworkVar("Float", 0, "NextPrimaryFire")
	self:NetworkVar("Float", 1, "NextSecondaryFire")

	self:NetworkVar("Float", 2, "LeftBarrelOffset")
	self:NetworkVar("Float", 3, "RightBarrelOffset")

	self:NetworkVar("Float", 4, "DieTime")

	self:NetworkVar("Bool", 0, "PrimaryBarrel")
	self:NetworkVar("Bool", 1, "SecondaryBarrel")
end

function ENT:Think()
	self:NextThink(CurTime())

	self:UpdatePlayer()
	self:UpdateBoneManip()

	return true
end

function ENT:FirePrimary(vehicle)
	if SERVER then
		self:EmitSound("Terminator_Turret.Primary")
	end

	local barrel = self:GetPrimaryBarrel()
	local attachment = barrel and 3 or 1

	self:SetPrimaryBarrel(not barrel)

	if barrel then
		self:SetRightBarrelOffset(CurTime())
	else
		self:SetLeftBarrelOffset(CurTime())
	end

	local ply = self:GetPlayer()

	local pos = self:GetCameraPos(ply:EyeAngles(), vehicle)
	local attPos = self:GetAttachment(attachment).Pos

	local dir = (util.TraceLine({
		start = pos,
		endpos = pos + ply:EyeAngles():Forward() * 32768,
		filter = self,
		mask = MASK_SHOT
	}).HitPos - attPos):GetNormalized()

	local spread = math.rad(util.RangeMeters(50))
	local bullet = {}

	bullet.Attacker 	= self:GetPlayer()
	bullet.HullSize 	= 8
	bullet.Num 			= 1
	bullet.Src 			= self:GetAttachment(attachment).Pos
	bullet.Dir 			= dir
	bullet.Spread 		= Vector(spread, spread, 0)
	bullet.Damage 		= 60
	bullet.Tracer 		= 0
	bullet.Force 		= bullet.Damage * 0.3
	bullet.Callback 	= function(attacker, tr, dmginfo)
		local effect = EffectData()

		effect:SetOrigin(tr.HitPos)
		effect:SetStart(tr.StartPos)

		util.Effect("trp_turrettracer", effect)

		effect = EffectData()
		effect:SetOrigin(tr.StartPos)
		effect:SetAngles(tr.Normal:Angle())
		effect:SetScale(3)

		util.Effect("MuzzleEffect", effect)
	end

	if IsFirstTimePredicted() then
		self:FireBullets(bullet)
	end

	self:SetNextPrimaryFire(CurTime() + 0.5)
end

function ENT:FireSecondary(vehicle)
	if SERVER then
		self:EmitSound("Terminator_Turret.Secondary")
	end

	local barrel = self:GetSecondaryBarrel()
	local attachment = barrel and 4 or 2

	self:SetSecondaryBarrel(not barrel)

	if barrel then
		self:SetRightBarrelOffset(CurTime())
	else
		self:SetLeftBarrelOffset(CurTime())
	end

	local ply = self:GetPlayer()

	local pos = self:GetCameraPos(ply:EyeAngles(), vehicle)
	local attPos = self:GetAttachment(attachment).Pos

	local dir = (util.TraceLine({
		start = pos,
		endpos = pos + ply:EyeAngles():Forward() * 32768,
		filter = self,
		mask = MASK_SHOT
	}).HitPos - attPos):GetNormalized()

	local spread = math.rad(util.RangeMeters(50))
	local bullet = {}

	bullet.Attacker 	= self:GetPlayer()
	bullet.HullSize 	= 8
	bullet.Num 			= 1
	bullet.Src 			= self:GetAttachment(attachment).Pos
	bullet.Dir 			= dir
	bullet.Spread 		= Vector(spread, spread, 0)
	bullet.Damage 		= 500
	bullet.Tracer 		= 0
	bullet.Force 		= bullet.Damage * 0.3
	bullet.Callback 	= function(attacker, tr, dmginfo)
		local effect = EffectData()

		effect:SetEntity(self)
		effect:SetOrigin(tr.HitPos)
		effect:SetStart(tr.StartPos)

		util.Effect("trp_turretlaser", effect)

		effect = EffectData()
		effect:SetEntity(self)
		effect:SetAttachment(attachment)

		util.Effect("GunshipMuzzleFlash", effect)

		if not tr.HitSky then
			ParticleEffect("grenade_explosion_01", tr.HitPos + tr.HitNormal, angle_zero)

			if SERVER then
				local ent = ents.Create("env_explosion")

				ent:SetPos(tr.HitPos)
				ent:SetOwner(ply)

				ent:SetKeyValue("spawnflags", 804)
				ent:SetKeyValue("iMagnitude", 60)

				ent:Spawn()
				ent:Activate()
				ent:Fire("Explode")
			end
		end
	end

	if IsFirstTimePredicted() then
		self:FireBullets(bullet)
	end

	self:SetNextSecondaryFire(CurTime() + 2)
end

function ENT:UpdateBoneManip()
	local dir = self:GetAngles()
	local ply = self:GetPlayer()

	if IsValid(ply) then
		dir = ply:EyeAngles()
	end

	local ang = self:WorldToLocalAngles(dir)

	if self:Health() <= 0 then
		local frac = math.Clamp(math.TimeFraction(self:GetDieTime(), self:GetDieTime() + 2, CurTime()), 0, 1)

		self:ManipulateBoneAngles(1, Angle(0, 0, 0))
		self:ManipulateBoneAngles(4, Angle(0, math.EasedFrac(frac, 0, -10, math.ease.OutElastic), math.EasedFrac(frac, 0, 10, math.ease.OutBack)))

		self:ManipulateBoneAngles(7, Angle(0, math.EasedFrac(frac, 0, -20, math.ease.OutBack), math.EasedFrac(frac, 0, 20, math.ease.OutQuint)))
		self:ManipulateBoneAngles(8, Angle(math.EasedFrac(frac, 0, -15, math.ease.OutBack), 0, math.EasedFrac(frac, 0, -40, math.ease.OutElastic)))

		self:ManipulateBoneAngles(9, Angle(0, 0, math.EasedFrac(frac, 0, 50, math.ease.OutBounce)))
		self:ManipulateBoneAngles(10, Angle(0, 0, -math.EasedFrac(frac, 0, 60, math.ease.OutElastic)))

		return
	end

	self:ManipulateBoneAngles(1, Angle(ang.y, 0, 0), false)

	local height = Angle(0, 0, math.EasedRemap(ang.p, -35, 15, 45, 0, math.ease.InOutSine))

	self:ManipulateBoneAngles(7, -height)
	self:ManipulateBoneAngles(9, -height)

	local pitch = Angle(0, 0, ang.p * 0.5)

	self:ManipulateBoneAngles(4, pitch)
	self:ManipulateBoneAngles(8, -pitch + height)
	self:ManipulateBoneAngles(10, -pitch + height)

	local offset = LocalToWorld(Vector(0, math.EasedRemap(CurTime() - self:GetLeftBarrelOffset(), 0, 0.5, -25, 0, math.ease.OutCirc), 0), angle_zero, vector_origin, -pitch + height)
	local offset2 = LocalToWorld(Vector(0, math.EasedRemap(CurTime() - self:GetRightBarrelOffset(), 0, 0.5, -25, 0, math.ease.OutCirc), 0), angle_zero, vector_origin, -pitch + height)

	self:ManipulateBonePosition(8, offset)
	self:ManipulateBonePosition(10, offset2)
end

function ENT:UpdatePlayer()
	local ply = self:GetPlayer()

	if not IsValid(ply) then
		return NULL
	end

	if not ply:InVehicle() then
		ply:SetNoDraw(false)

		self:SetPlayer(NULL)

		ply:SetPos(self:LocalToWorld(Vector(-100, 0, 10)))
		ply:SetEyeAngles(self:GetAngles())

		if SERVER then
			SafeRemoveEntity(self.Seat)
		end
	end
end

function ENT:GetCameraPos(ang, vehicle)
	if vehicle:GetThirdPersonMode() then
		return LocalToWorld(Vector(-200, 0, 150), angle_zero, self:WorldSpaceCenter(), ang)
	else
		local bone = self:GetBoneMatrix(4)

		return LocalToWorld(Vector(0, 105, -25), angle_zero, bone:GetTranslation(), bone:GetAngles())
	end
end

if SERVER then
	function ENT:Use(ply)
		if IsValid(self:GetPlayer()) then
			return
		end

		if self:Health() <= 0 then
			return
		end

		self.Seat = ents.Create("prop_vehicle_prisoner_pod")
		self.Seat:SetModel("models/props_lab/cactus.mdl")
		self.Seat:SetPos(self:WorldSpaceCenter())
		self.Seat:SetSolid(SOLID_NONE)
		self.Seat:SetKeyValue("limitview", 0, 0)
		self.Seat:SetNoDraw(true)
		self.Seat:Spawn()
		self.Seat:SetParent(self)
		self.Seat:SetNotSolid(true)

		self:DeleteOnRemove(self.Seat)

		ply:SetNoDraw(true)
		ply:EnterVehicle(self.Seat)

		self:SetPlayer(ply)
	end

	function ENT:OnRemove()
		local ply = self:GetPlayer()

		if IsValid(ply) then
			ply:SetNoDraw(false)
		end
	end

	function ENT:OnTakeDamage(dmg)
		if self:Health() <= 0 or not dmg:IsExplosionDamage() then
			return 0
		end

		self:SetHealth(self:Health() - dmg:GetDamage())

		if self:Health() <= 0 then
			self:SetDieTime(CurTime())
		end

		return BaseClass.OnTakeDamage(self, dmg)
	end
end

hook.Add("VehicleMove", "turret", function(ply, vehicle, mv)
	local turret = vehicle:GetParent()

	if not IsValid(turret) or turret:GetClass() != "cc_turret" then
		return
	end

	if turret:Health() <= 0 then
		return
	end

	if mv:KeyDown(IN_ATTACK) and CurTime() >= turret:GetNextPrimaryFire() then
		turret:FirePrimary(vehicle)
	end

	if mv:KeyDown(IN_ATTACK2) and CurTime() >= turret:GetNextSecondaryFire() then
		turret:FireSecondary(vehicle)
	end
end)

if CLIENT then
	hook.Add("PrePlayerDraw", "turret", function(ply)
		if not ply:InVehicle() then
			return
		end

		local turret = ply:GetVehicle():GetParent()

		if not IsValid(turret) or turret:GetClass() != "cc_turret" then
			return
		end

		return true
	end)

	hook.Add("HUDPaintBackground", "turret", function()
		local ply = LocalPlayer()

		if not ply:InVehicle() then
			return
		end

		local vehicle = ply:GetVehicle()
		local turret = vehicle:GetParent()

		if ply:GetViewEntity() != ply then
			return
		end

		if not IsValid(turret) or turret:GetClass() != "cc_turret" then
			return
		end

		if turret:Health() <= 0 then
			return
		end

		local ang = ply:EyeAngles()

		local pos = turret:GetCameraPos(ang, vehicle)
		local screen = util.TraceLine({
			start = pos,
			endpos = pos + ang:Forward() * 32768,
			filter = turret,
			mask = MASK_SHOT
		}).HitPos:ToScreen()

		if screen.visible then
			local x = screen.x - 1
			local y = screen.y - 1

			local half = math.rad(LocalPlayer():GetFOV()) * 0.5
			local ref = 320 / math.tan(half)

			local offset = math.Round(math.rad(util.RangeMeters(50)) * ref * (ScrH() / 480))

			surface.SetDrawColor(255, 255, 255)

			render.OverrideBlend(true, BLEND_ONE_MINUS_DST_COLOR, BLEND_ZERO, BLENDFUNC_ADD)

			local length = 5

			surface.DrawRect(x - offset - length, y, length, 2) -- Left
			surface.DrawRect(x + offset + 2, y, length, 2) -- Right

			length = 2

			surface.DrawRect(x, y - offset - length, 2, length) -- Up
			surface.DrawRect(x, y + offset + 2, 2, length) -- Down

			render.OverrideBlend(false)
		end
	end)

	hook.Add("CalcView", "turret", function(ply, origin, angle, fov, znear, zfar)
		if ply != LocalPlayer() or not ply:InVehicle() then
			return
		end

		local vehicle = ply:GetVehicle()
		local turret = vehicle:GetParent()

		if ply:GetViewEntity() != ply then
			return
		end

		if not IsValid(turret) or turret:GetClass() != "cc_turret" then
			return
		end

		local pos = turret:GetCameraPos(angle, vehicle)

		local view = {
			origin = pos,
			angles = angle,
			fov = fov,
			drawviewer = false
		}

		return view
	end)

	function ENT:OnRemove()
		self:SetPredictable(false)
	end

	function ENT:Draw()
		self:UpdateShadow()
		self:DrawModel()
	end

	function ENT:DrawTranslucent()
	end
end
