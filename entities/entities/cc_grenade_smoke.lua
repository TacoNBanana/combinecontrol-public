AddCSLuaFile()
DEFINE_BASECLASS("cc_grenade_frag")

ENT.Base 		= "cc_grenade_frag"

ENT.PrintName 	= "Smoke Grenade"
ENT.Category	= "CombineControl - World"

ENT.Spawnable 	= true

ENT.Model 		= Model("models/weapons/w_eq_smokegrenade.mdl")

function ENT:Initialize()
	BaseClass.Initialize(self)

	self:SetColor(Color(135, 135, 135))
end

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "DoRemove")
end

function ENT:GetSmokeColor()
	return self:GetSmokeVec():ToColor()
end

function ENT:CanPhysgun()
	return not self:GetDoRemove()
end

function ENT:Think()
	BaseClass.Think(self)
end

function ENT:Draw()
	local r, g, b = render.GetColorModulation()
	local a = render.GetBlend()

	render.SetColorModulation(1, 1, 1)
	render.SetBlend(1)

	self:DrawModel()

	render.SetColorModulation(r, g, b)
	render.SetBlend(a)
end

function ENT:Use(ply)
	if not self.DetonateTime then
		self:SetTimer(1)
	end

	ply:PickupObject(self)
end

function ENT:Explode()
	local ed = EffectData()
		ed:SetOrigin(self:WorldSpaceCenter())
		ed:SetEntity(self)
	util.Effect("cc_e_smokegrenade", ed)

	self:EmitSound(Sound("weapons/smokegrenade/sg_explode.wav"))

	if self:GetDoRemove() then
		SafeRemoveEntityDelayed(self, math.random(50, 90))
	end
end
