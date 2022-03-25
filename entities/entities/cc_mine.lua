AddCSLuaFile()
DEFINE_BASECLASS("cc_worldent")

ENT.Base 				= "cc_worldent"

ENT.RenderGroup 		= RENDERGROUP_BOTH

ENT.PrintName 			= "Anti-personnel mine"
ENT.Category 			= "CombineControl - World"

ENT.Spawnable 			= true
ENT.AdminSpawnable 		= true

ENT.Model 				= Model("models/blu/mine.mdl")
ENT.ModelScale 			= 0.5
ENT.Radius 				= 32

function ENT:SpawnFunction(ply, tr, classname)
	if tr.HitNormal:Dot(Vector(0, 0, 1)) <= 0 then
		ply:SendChat(nil, "ERROR", "Error: Mines cannot be placed on walls!")

		return
	end

	local ent = BaseClass.SpawnFunction(self, ply, tr, classname)

	if not IsValid(ent) then
		return
	end

	local ang = tr.HitNormal:Angle()

	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(tr.HitNormal, math.random(0, 359))

	ent:SetPos(tr.HitPos)
	ent:SetAngles(ang)

	ent:Save()
end

function ENT:Initialize()
	self:SetModel(self.Model)

	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetTrigger(true)

		self:PhysWake()
	end

	if self.ModelScale != 1 then
		self:SetModelScale(self.ModelScale, 0.0001)
	end

	self:UseTriggerBounds(true, self.Radius)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	if CLIENT then
		local mins, maxs = self:GetModelBounds()

		self:SetRenderBounds(mins, maxs, Vector(self.Radius, self.Radius, self.Radius * 0.5))
	end
end

function ENT:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Bool", 0, "Persistent")
end

function ENT:GetContextOptions(ply)
	local tab = BaseClass.GetContextOptions(self, ply)

	if ply:IsAdmin() then
		table.insert(tab, {
			Name = "Toggle persistent",
			Callback = function()
				self:SetPersistent(not self:GetPersistent())
				self:Save()
			end
		})
	end

	return tab
end

if CLIENT then
	function ENT:Draw()
		local ply = LocalPlayer()

		if ply:IsAdmin() and GAMEMODE.SeeAll then
			self:DrawShadow(true)
			self:DrawModel()

			return
		end

		local dist = ply:GetPos():DistToSqr(self:WorldSpaceCenter())

		if dist > 128 * 128 then
			self:DrawShadow(false)

			return
		end

		local maxDist = (self.Radius + 128) ^ 2
		local minDist = (self.Radius + 64) ^ 2

		local alpha = math.RemapC(dist, maxDist, minDist, 0, 1)

		self:DrawShadow(alpha == 1)

		render.SetBlend(alpha)
			self:DrawModel()
		render.SetBlend(1)
	end

	local baseColor = Color(255, 0, 0, 100)
	local persistColor = Color(255, 93, 0, 100)

	function ENT:DrawTranslucent()
		if LocalPlayer():IsAdmin() and GAMEMODE.SeeAll then
			local min = -Vector(self.Radius, self.Radius, 0)
			local max = Vector(self.Radius, self.Radius, self.Radius / 2)

			render.SetColorMaterial()
			render.DrawBox(self:GetPos(), angle_zero, min, max, self:GetPersistent() and persistColor or baseColor)
		end
	end
else
	function ENT:StartTouch(ply)
		if self.Exploded or not self:IsReady() then
			return true
		end

		if not ply:IsPlayer() or ply:Crouching() then
			return
		end

		local pos = self:GetPos()

		GAMEMODE:SoundRange(pos, 5000, "gbombs_5/explosions/light_bomb/mine_explosion.mp3")

		local ent = ents.Create("cc_shockwave")

		ent:SetPos(self:GetPos())
		ent:SetAngles(angle_zero)
		ent:SetOwner(ply)

		ent.MaxRange = 100
		ent.Damage = 500
		ent.Force = 155

		ent:Spawn()
		ent:Activate()

		timer.Simple(0, function()
			ParticleEffect("high_explosive_main", pos, angle_zero)
		end)

		if not self:GetPersistent() then
			self:SetNoDraw(true)
			self:Delete()

			SafeRemoveEntityDelayed(self, 2)
		end
	end

	function ENT:GetCustomData()
		return {
			Persistent = self:GetPersistent()
		}
	end

	function ENT:LoadCustomData(data)
		self:SetPersistent(data.Persistent)
	end
end
