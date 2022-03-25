AddCSLuaFile()
DEFINE_BASECLASS("cc_worldent")

ENT.Base 			= "cc_worldent"
ENT.RenderGroup 	= RENDERGROUP_OPAQUE

ENT.PrintName 		= "Teleport exit"
ENT.Category 		= "CombineControl - Zones"

ENT.Spawnable 		= true
ENT.AdminSpawnable 	= true

ENT.Model 			= Model("models/editor/playerstart.mdl")

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
end

function ENT:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Int", 1, "Group")
end

function ENT:Think()
	self:SetColor(Color(255, 223, 127))

	self:RemoveAllDecals()
end

function ENT:GetContextOptions(ply)
	local tab = BaseClass.GetContextOptions(self, ply)

	if ply:IsAdmin() and not self:IsReady() then
		local done = {}

		table.insert(tab, {
			Name = "Set group: 0",
			Callback = function()
				self:SetGroup(0)
			end
		})

		for _, v in pairs(ents.FindByClass("cc_zone_teleport")) do
			local group = v:GetGroup()

			if group != 0 and v != self and not done[group] then
				done[group] = true

				table.insert(tab, {
					Name = string.format("Set group: %i", group),
					Callback = function()
						self:SetGroup(group)
					end
				})
			end
		end
	end

	return tab
end

if CLIENT then
	function ENT:Draw()
		if LocalPlayer():IsAdmin() and GAMEMODE.SeeAll then
			self:DrawModel()

			GAMEMODE:DrawWorldText(self:WorldSpaceCenter() + Vector(0, 0, self:BoundingRadius()), self:GetGroup())
		end

		if not self:IsReady() then
			self:DrawModel()

			return
		end
	end
end

if SERVER then
	function ENT:IsSuitable(ply)
		local pos = self:GetPos()
		local tab = ents.FindInBox(pos + Vector(-16, -16, 0), pos + Vector(16, 16, 72))

		for _, v in pairs(tab) do
			if IsValid(v) and v:IsPlayer() and v:Alive() and v != ply then
				return false
			end
		end

		return true
	end

	function ENT:GetCustomData()
		return {
			Group = self:GetGroup()
		}
	end

	function ENT:LoadCustomData(data)
		self:SetGroup(data.Group)
	end
end
