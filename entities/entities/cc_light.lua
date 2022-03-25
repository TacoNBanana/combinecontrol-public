AddCSLuaFile()
DEFINE_BASECLASS("cc_worldent")

ENT.Base 				= "cc_worldent"
ENT.RenderGroup 		= RENDERGROUP_OPAQUE

ENT.PrintName 			= "Light"
ENT.Category 			= "CombineControl - World"

ENT.Spawnable 			= true
ENT.AdminSpawnable 		= true

ENT.Model 				= Model("models/props_industrial/cagelight01.mdl")

ENT.Styles 				= {
	{false, 0},
	{Color(210, 176, 143, 200), 1, 0},
	{Color(210, 176, 143, 200), 1, 1},
	{Color(210, 176, 143, 200), 1, 6},
	{Color(255, 0, 0), 3, 0}
}

ENT.Brightness = 1
ENT.Size = 512

function ENT:SpawnFunction(ply, tr, classname)
	local ent = BaseClass.SpawnFunction(self, ply, tr, classname)

	if not IsValid(ent) then
		return
	end

	ent:SetPos(ent:GetPos() + Vector(0, 0, 30))

	return ent
end

function ENT:Initialize()
	self:SetModel(self.Model)

	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end
end

function ENT:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Int", 1, "Style")
	self:NetworkVar("Int", 2, "LightGroup")
end

function ENT:Think()
	local style = self:GetStyle()
	local data = self.Styles[math.Clamp(style + 1, 0, #self.Styles)]

	self:SetSkin(data[2])

	if CLIENT and not self:IsDormant() then
		local col = data[1]

		if col then
			local dlight = DynamicLight(self:EntIndex())

			if dlight then
				dlight.Pos = self:LocalToWorld(Vector(0, 0, -30))
				dlight.r = col.r
				dlight.g = col.g
				dlight.b = col.b
				dlight.Brightness = self.Brightness
				dlight.Decay = self.Size * 5
				dlight.Size = self.Size
				dlight.DieTime = CurTime() + 1
				dlight.Style = data[3]
			end
		end
	end
end

function ENT:GetContextOptions(ply)
	local tab = BaseClass.GetContextOptions(self, ply)

	if ply:IsAdmin() and not self:IsReady() then
		local done = {}

		table.insert(tab, {
			Name = "Set group: 0",
			Callback = function()
				self:SetLightGroup(0)
			end
		})

		for _, v in pairs(ents.FindByClass("cc_light*")) do
			local group = v:GetLightGroup()

			if group != 0 and v != self and not done[group] then
				done[group] = true

				table.insert(tab, {
					Name = string.format("Set group: %i", group),
					Callback = function()
						self:SetLightGroup(group)
					end
				})
			end
		end

		table.insert(tab, {
			Name = "Set as new group",
			Callback = function()
				self:SetLightGroup(#done + 1)
			end
		})
	end

	return tab
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()

		if GAMEMODE.SeeAll and LocalPlayer():IsAdmin() then
			GAMEMODE:DrawWorldText(self:LocalToWorld(Vector(0, 0, -15)), self:GetLightGroup())
		end
	end
else
	function ENT:GetCustomData()
		return {
			Style = self:GetStyle(),
			Group = self:GetLightGroup()
		}
	end

	function ENT:LoadCustomData(data)
		self:SetStyle(data.Style)
		self:SetLightGroup(data.Group)
	end
end
