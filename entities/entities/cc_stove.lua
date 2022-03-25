AddCSLuaFile()

ENT.Base = "cc_base_ent"
ENT.Type = "anim"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "StoveOn")
	self:NetworkVar("Bool", 1, "Invisible")
	self:NetworkVar("String", 0, "Building")
	self:NetworkVar("Int", 0, "Deployer")
end

function ENT:Initialize()
	if CLIENT then
		return
	end

	self:SetUseType(SIMPLE_USE)

	self:SetStoveOn(false)

	self:SetModel(Model("models/props_c17/furniturestove001a.mdl"))
	self:PhysicsInit(SOLID_VPHYSICS)
end

function ENT:Use(ply)
	if SERVER then
		if self:GetBuilding() ~= "" and not table.HasValue(ply:OwnedBuildings(), self:GetBuilding()) and not table.HasValue(ply:AssignedBuildings(), self:GetBuilding()) then
			net.Start("nUnownedStove")
			net.Send(ply)

			return
		end

		self:EmitSound(Sound("buttons/lightswitch2.wav"))

		self:SetStoveOn(not self:GetStoveOn())

		if (not self.SteamEnt or not self.SteamEnt:IsValid()) and self:GetModel() ~= "models/props_c17/tv_monitor01.mdl" then
			local pos = self:GetPos()

			if string.lower(self:GetModel()) == "models/props_wasteland/kitchen_stove001a.mdl" then
				pos = self:GetPos() + self:GetRight() * -20 + self:GetUp() * 18
			end

			self.SteamEnt = ents.Create("env_smokestack")
			self.SteamEnt:SetPos(pos)
			self.SteamEnt:SetKeyValue("BaseSpread", "1")
			self.SteamEnt:SetKeyValue("SpreadSpeed", "30")
			self.SteamEnt:SetKeyValue("Speed", "50")
			self.SteamEnt:SetKeyValue("StartSize", "3")
			self.SteamEnt:SetKeyValue("EndSize", "5")
			self.SteamEnt:SetKeyValue("roll", "10")
			self.SteamEnt:SetKeyValue("Rate", "700")
			self.SteamEnt:SetKeyValue("JetLength", "30")
			self.SteamEnt:SetKeyValue("twist", "5")
			self.SteamEnt:SetKeyValue("SmokeMaterial", "sprites/heatwave")

			self.SteamEnt:Spawn()
			self.SteamEnt:SetParent(self)
			self.SteamEnt:Activate()

			self:DeleteOnRemove(self.SteamEnt)
		end

		if self:GetStoveOn() then
			if IsValid(self.SteamEnt) then
				self.SteamEnt:Fire("TurnOn")
			end

			self.ExplodeTime = CurTime() + math.random(600, 900)
			self.NextExplodeCheck = nil
		else
			if IsValid(self.SteamEnt) then
				self.SteamEnt:Fire("TurnOff")
			end
		end
	end
end

function ENT:CanPhysgun()
	return self:GetDeployer() > 0
end

ENT.LightMat = Material("particle/fire")

function ENT:Draw()
	if not self:GetInvisible() then
		self:DrawModel()
		self:DrawShadow(true)

		if self:GetStoveOn() and self:GetModel() == "models/props_c17/tv_monitor01.mdl" then
			render.SetMaterial(self.LightMat)
			render.DrawSprite(self:GetPos() + self:GetForward() * 9 + self:GetRight() * -8 + self:GetUp() * 4, 8, 8, Color(255, 255, 200, 255), false)
		end
	else
		self:DrawShadow(false)
	end
end