AddCSLuaFile()

ENT.Base = "cc_base_ent"
ENT.Type = "anim"

ENT.Category		= "CombineControl"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.AllowPhys 		= true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Channel")
	self:NetworkVar("Int", 1, "Deployer")
end

function ENT:Initialize()
	if CLIENT then
		return
	end

	self:SetModel(Model("models/props_lab/citizenradio.mdl"))
	self:PhysicsInit(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
	end
end

ENT.LightMat = Material("sprites/light_glow02_add")

function ENT:Draw()
	self:DrawModel()

	render.SetMaterial(self.LightMat)
	render.DrawSprite(self:LocalToWorld(Vector(10, 8.8, 7.5)), 8, 8, Color(255, 255, 150, 255))
end
