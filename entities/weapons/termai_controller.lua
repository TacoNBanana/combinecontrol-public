AddCSLuaFile()

SWEP.PrintName 				= "Terminator AI Controller"
SWEP.Author 				= "TankNut"

SWEP.RenderGroup 			= RENDERGROUP_OPAQUE

SWEP.Slot 					= 3
SWEP.SlotPos 				= 6

SWEP.DrawWeaponInfoBox 		= false
SWEP.DrawCrosshair 			= true

SWEP.ViewModelFOV 			= 54

SWEP.ViewModel 				= Model("models/weapons/c_arms.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= true

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Ammo 			= ""
SWEP.Primary.Automatic 		= false

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Ammo 		= ""
SWEP.Secondary.Automatic 	= false

if SERVER then
	util.AddNetworkString("nSyncControllerSelection")
end

function SWEP:Initialize()
	self:SetHoldType("normal")
	self.Selection = {}
end

function SWEP:SetupDataTables()
	self:NetworkVar("Vector", 0, "StartPoint")

	self:NetworkVar("Bool", 0, "InSelection")
end

function SWEP:PrimaryAttack()
	self:SetStartPoint(self:GetOwner():GetEyeTrace().HitPos)
	self:SetInSelection(true)
end

function SWEP:SecondaryAttack()
	if CLIENT then
		return
	end

	local target = self:GetOwner():GetEyeTrace().HitPos

	local positions = {}
	local center = Vector()

	for ent in pairs(self.Selection) do
		if not IsValid(ent) then
			continue
		end

		local pos = ent:GetPos()

		positions[ent] = pos

		center:Add(pos)
	end

	center:Div(table.Count(positions))

	for ent, v in pairs(positions) do
		local pos = WorldToLocal(v, Angle(), center, Angle())

		pos.z = 0

		positions[ent] = pos
	end

	for ent, pos in pairs(positions) do
		ent:SetSaveValue("m_vSavePosition", target + pos)
		ent:SetCustomSchedule("Control_MoveTo")
	end
end

function SWEP:Reload()
	if CLIENT then
		return
	end

	for ent in pairs(self.Selection) do
		if not IsValid(ent) then
			continue
		end

		ent:SetCustomSchedule("Wander")
	end

	self:AddToSelection({}, true)

	table.Empty(self.Selection)
end

function SWEP:Think()
	local ply = self:GetOwner()

	if self:GetInSelection() and not ply:KeyDown(IN_ATTACK) then
		local tr = ply:GetEyeTrace()

		local endpoint = tr.HitPos
		local center = (self:GetStartPoint() + endpoint) * 0.5
		local radius = center:Distance(endpoint)

		if radius < 10 then
			local ent = tr.Entity

			if IsValid(ent) and ent.TerminatorAI then
				self:AddToSelection({ent})
			else
				self:AddToSelection({})
			end
		else
			local tab = {}

			for _, v in pairs(ents.FindInSphere(center, radius)) do
				if not IsValid(v) or not v.TerminatorAI then
					continue
				end

				table.insert(tab, v)
			end

			self:AddToSelection(tab)
		end

		self:SetInSelection(false)
	end
end

function SWEP:AddToSelection(tab, force)
	local ply = self:GetOwner()

	if not ply:KeyDown(IN_SPEED) or force then
		table.Empty(self.Selection)
	end

	for _, v in pairs(tab) do
		self.Selection[v] = true
	end

	if SERVER then
		net.Start("nSyncControllerSelection")
			net.WriteUInt(table.Count(self.Selection), 10)

		for k in pairs(self.Selection) do
			if IsValid(k) then
				net.WriteEntity(k)

				if not string.find(k.ActiveSchedule, "Control") then
					k:SetCustomSchedule("Control_Idle")
				end
			end
		end

		net.Send(ply)
	end
end

if CLIENT then
	local color = Color(222, 92, 0, 50)
	local color2 = Color(222, 92, 0, 255)

	function SWEP:PostDrawViewModel(vm)
		cam.Start3D()

		local ply = self:GetOwner()

		render.SetColorMaterial()

		if self:GetInSelection() then
			local endpoint = ply:GetEyeTrace().HitPos
			local center = (self:GetStartPoint() + endpoint) * 0.5
			local radius = center:Distance(endpoint)

			render.DrawSphere(center, radius, 50, 50, color)
			render.DrawSphere(center, -radius, 50, 50, color)
		end

		for ent in pairs(self.Selection) do
			if not IsValid(ent) then
				continue
			end

			local mins, maxs = ent:GetModelRenderBounds()
			local scale = ent:GetModelScale()

			render.DrawBox(ent:GetPos(), ent:GetAngles(), mins * scale, maxs * scale, color)
			render.DrawWireframeBox(ent:GetPos(), ent:GetAngles(), mins * scale, maxs * scale, color2)

			cam.Start3D2D(ent:WorldSpaceCenter(), Angle(0, 0, 0), 1)
				surface.DrawCircle(0, 0, 450, color2:Unpack())
			cam.End3D2D()
		end

		cam.End3D()
	end

	net.Receive("nSyncControllerSelection", function(len)
		local weapon = LocalPlayer():GetWeapon("termai_controller")

		if not IsValid(weapon) then
			return
		end

		local count = net.ReadUInt(10)

		table.Empty(weapon.Selection)

		for i = 1, count do
			local ent = net.ReadEntity()

			weapon.Selection[ent] = true
		end
	end)
end
