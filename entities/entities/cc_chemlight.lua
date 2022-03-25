AddCSLuaFile()
DEFINE_BASECLASS("cc_worldent")

ENT.Base 			= "cc_worldent"
ENT.RenderGroup 	= RENDERGROUP_OPAQUE

ENT.PrintName 		= "Chemlight"
ENT.Category		= "CombineControl - World"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Model 			= Model("models/glowstick/stick.mdl")

ENT.FadeTime 		= 900 -- 15 minutes

ENT.Color 			= Color(0, 255, 63)

function ENT:Initialize()
	self:SetModel(self.Model)

	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetUseType(SIMPLE_USE)
	end

	self:PhysWake()
	self:SetColor(self.Color)
	self:SetVecColor(self.Color:ToVector())

	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	if GAMEMODE:AprilFools() then
		self:SetRainbow(true)
	end
end

function ENT:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Bool", 0, "Rainbow")

	self:NetworkVar("Int", 1, "Channel")

	self:NetworkVar("Float", 0, "DieTime")
	self:NetworkVar("Vector", 0, "VecColor")
end

function ENT:CanSave()
	return self:GetDieTime() == 0
end

if CLIENT then
	function ENT:Think()
		if not self:IsReady() and self:IsDormant() then
			return
		end

		if self:IsReady() and self:WorldSpaceCenter():DistToSqr(LocalPlayer():EyePos()) > 8000^2 then
			return
		end

		local dlight = DynamicLight(self:EntIndex())

		if dlight then
			local size = 256
			local col = self:GetVecColor()
			local die = self:GetDieTime()

			if self:GetRainbow() then
				local time = (CurTime() - self:GetCreationTime()) * 10

				col = HSVToColor(time % 360, 1, 1):ToVector()
			end

			if die != 0 then
				local frac = math.RemapC(die - CurTime(), self.FadeTime, 0, 1, 0)

				size = size * frac

				col = LerpVector(frac, vector_origin, col)
			end

			col = col:ToColor()

			self:SetColor(col)

			dlight.Pos = self:WorldSpaceCenter()
			dlight.r = col.r
			dlight.g = col.g
			dlight.b = col.b
			dlight.Brightness = 0
			dlight.Decay = size * 5
			dlight.Size = size
			dlight.DieTime = CurTime() + 1
		end
	end
else
	function ENT:Use(ply)
		if self:IsReady() or self:IsPlayerHolding() then
			return
		end

		ply:PickupObject(self)
	end

	function ENT:Think()
		local die = self:GetDieTime()

		if die != 0 and die <= CurTime() then
			SafeRemoveEntity(self)

			return
		end

		if die == 0 then
			local vec = self:GetColor():ToVector()

			if vec != self:GetVecColor() then
				self:SetVecColor(vec)
			end
		end
	end

	function ENT:GetCustomData()
		return {
			Color = self:GetVecColor()
		}
	end

	function ENT:LoadCustomData(data)
		self:SetVecColor(data.Color)
		self:SetColor(data.Color:ToColor())
	end
end
