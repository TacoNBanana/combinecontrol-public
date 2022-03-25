AddCSLuaFile()
DEFINE_BASECLASS("cc_worldent")

ENT.Base 			= "cc_worldent"
ENT.RenderGroup 	= RENDERGROUP_OPAQUE

ENT.PrintName 		= "Stationary radio"
ENT.Category		= "CombineControl - World"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Model 			= Model("models/z-o-m-b-i-e/metro_2033/equipment/m33_radiostation_02.mdl")

function ENT:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Int", 1, "Channel")
end

function ENT:Initialize()
	if CLIENT then
		return
	end

	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
	end

	self:SetChannel(2000)
end

if CLIENT then
	function ENT:Think()
		self:SetNextClientThink(CurTime() + math.random(20, 60))
		self:EmitSound("radio/radio_cutoff_0" .. math.random(1, 5) .. ".wav")

		return true
	end
else
	function ENT:GetCustomData()
		return {
			Channel = self:GetChannel()
		}
	end

	function ENT:LoadCustomData(data)
		self:SetChannel(data.Channel)
	end
end
