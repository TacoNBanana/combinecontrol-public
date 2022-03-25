AddCSLuaFile()
DEFINE_BASECLASS("cc_worldent")

ENT.Base 			= "cc_worldent"

ENT.Category		= "CombineControl"
ENT.RenderGroup  	= RENDERGROUP_OPAQUE

ENT.PrintName 		= "Workbench"
ENT.Category 		= "CombineControl - World"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.AllowPhys 		= true

local wiremat = Material("models/wireframe")

function ENT:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Float", 0, "CraftStart")
	self:NetworkVar("Float", 1, "CraftEnd")
	self:NetworkVar("Float", 2, "CraftTime")
	self:NetworkVar("String", 0, "RenderModel")
end

function ENT:Initialize()
	if CLIENT then
		return
	end

	self:SetUseType(SIMPLE_USE)

	self:SetModel(Model("models/props_c17/furnitureshelf001b.mdl"))
	self:SetMaterial("models/props_canal/metalwall005b")
	self:PhysicsInit(SOLID_VPHYSICS)
end

function ENT:OnRemove()
	if CLIENT then
		SafeRemoveEntity(self.CSEntity)
	end
end

function ENT:GetItems()
	local items = {}
	local mins, maxs = self:GetRotatedAABB(self:OBBMins(), self:OBBMaxs() + Vector(0, 0, 10))

	for _, v in pairs(ents.FindInBox(self:GetPos() + mins, self:GetPos() + maxs)) do
		if v:GetClass() == "cc_item" and not v.Item:IsTempItem() then
			table.insert(items, v.Item)
		end
	end

	return items
end

function ENT:EmitSounds()
	self:EmitSound(Sound("physics/metal/metal_box_impact_bullet1.wav"))

	local sounds = {
		Sound("physics/metal/metal_box_impact_bullet3.wav"),
		Sound("physics/metal/metal_box_impact_bullet2.wav"),
		Sound("physics/metal/metal_box_impact_bullet2.wav"),
		Sound("physics/metal/metal_box_impact_bullet1.wav")
	}

	for k, v in pairs(sounds) do
		timer.Simple(k * 0.4, function()
			if not IsValid(self) then
				return
			end

			self:EmitSound(v)
		end)
	end
end

function ENT:Use(ply)
	if self:GetCraftEnd() > CurTime() then
		return
	end

	net.Start("nCraftingMenu")
		net.WriteEntity(self)
	net.Send(ply)
end

function ENT:Draw()
	self:DrawModel()

	local mdl = self:GetRenderModel()
	local starttime = self:GetCraftStart()
	local endtime = self:GetCraftEnd()
	local crafttime = self:GetCraftTime()

	if #mdl < 1 then
		return
	end

	local pos = self:LocalToWorld(self:OBBCenter() + Vector(0, 0, 10))
	local ang = self:LocalToWorldAngles(Angle(0, CurTime() * 100, 0))

	if not IsValid(self.CSEntity) then
		self.CSEntity = ClientsideModel(Model("models/props_junk/PopCan01a.mdl"))
		self.CSEntity:SetMoveType(MOVETYPE_NONE)
		self.CSEntity:SetParent(self)
		self.CSEntity:SetPos(self:GetPos())
		self.CSEntity:SetAngles(self:GetAngles())
		self.CSEntity:SetNoDraw(true)
	end

	self.CSEntity:SetModel(mdl)
	self.CSEntity:SetPos(pos)
	self.CSEntity:SetAngles(ang)

	if endtime > CurTime() then
		local delta = ((CurTime() - starttime) % crafttime) / crafttime

		local mins = self.CSEntity:LocalToWorld(self.CSEntity:OBBMins())
		local maxs = self.CSEntity:LocalToWorld(self.CSEntity:OBBMaxs())

		local lerp = LerpVector(delta, mins, maxs)

		local normal = ang:Forward()
		local cut = normal:Dot(lerp)
		local cut2 = -normal:Dot(lerp)

		render.EnableClipping(true)

		render.PushCustomClipPlane(normal, cut)
		self:DrawWireframe()
		render.PopCustomClipPlane()

		render.PushCustomClipPlane(-normal, cut2)
		self.CSEntity:DrawModel()
		render.PopCustomClipPlane()

		render.EnableClipping(false)
	else
		self:DrawWireframe()
	end
end

function ENT:DrawWireframe(mat)
	render.MaterialOverride(wiremat)

	self.CSEntity:DrawModel()

	render.MaterialOverride()
end
