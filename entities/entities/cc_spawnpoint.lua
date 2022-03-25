AddCSLuaFile()

ENT.Base 			= "cc_worldent"
ENT.RenderGroup 	= RENDERGROUP_OPAQUE

ENT.PrintName 		= "Spawnpoint"
ENT.Category 		= "CombineControl - World"

ENT.Spawnable 		= true
ENT.AdminSpawnable 	= true

ENT.Model 			= Model("models/editor/playerstart.mdl")
ENT.Team 			= TEAM_CITIZEN

function ENT:Initialize()
	self:SetModel(self.Model)

	if SERVER then
		self:PhysicsInit(SOLID_BBOX)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_BBOX)

		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:Wake()
		end
	end

	self:DrawShadow(false)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	self:SetSubMaterial(0, "models/shiny")
	self:SetColor(team.GetColor(self.Team))
end

function ENT:Think()
	self:RemoveAllDecals()
end

if CLIENT then
	function ENT:Draw()
		if LocalPlayer():IsAdmin() and GAMEMODE.SeeAll then
			self:DrawModel()
		end

		if not self:IsReady() then
			self:DrawModel()

			return
		end
	end
end
