AddCSLuaFile()

ENT.Base = "cc_base_ent"
ENT.Type = "anim"

ENT.Category		= "CombineControl"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.AllowPhys 		= true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Enabled")
	self:NetworkVar("Int", 0, "Channel")
	self:NetworkVar("Int", 1, "Deployer")

	if SERVER then
		self:SetEnabled(false)
	end
end

function ENT:Initialize()
	if CLIENT then
		return
	end

	self:SetUseType(SIMPLE_USE)

	self:SetModel(Model("models/props_lab/reciever01b.mdl"))
	self:SetSkin(1)

	self:PhysicsInit(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
	end
end

function ENT:Use(activator, caller)
	if CLIENT then
		return
	end

	self:SetEnabled(not self:GetEnabled())

	self:SetSkin(self:GetEnabled() and 0 or 1)
	self:EmitSound(Sound("Buttons.snd14"))
end

ENT.LightMat = Material("sprites/light_glow02_add")

function ENT:Draw()
	self:DrawModel()

	if self:GetEnabled() then
		render.SetMaterial(self.LightMat)
		render.DrawSprite(self:LocalToWorld(Vector(6.75, 5.95, 1.3)), 4, 4, Color(255, 255, 150, 255))
	end
end