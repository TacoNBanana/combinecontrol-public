AddCSLuaFile()

ENT.Base = "cc_base_ent"

function ENT:PostEntityPaste(ply, ent, tab)
	GAMEMODE:LogSecurity(ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!")
	ent:Remove()
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Supply")
	self:NetworkVar("Float", 0, "Delay")
end

function ENT:Initialize()
	self:SetModel(Model("models/props_interiors/VendingMachineSoda01a.mdl"))
	self:SetSupply(math.random(5, 10))

	if SERVER then
		self:SetDelay(0)

		timer.Simple(0, function()
			net.Start("nVendingMachineUpdateSupply")
				net.WriteEntity(self)
				net.WriteInt(self:GetSupply(), 8)
			net.Broadcast()
		end)

		self:PhysicsInit(SOLID_BBOX)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_BBOX)

		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:EnableMotion(false)
		end

		self:SetUseType(SIMPLE_USE)
		self:NextThink(CurTime() + math.random(180, 300))
	end
end

function ENT:Use(ply)
	if SERVER then
		if self:GetDelay() > CurTime() then
			return
		end

		self:SetDelay(CurTime() + 2.5)

		if self:GetSupply() > 0 then
			if ply:Money() < 7 then
				self:EmitSound(Sound("Buttons.snd10"))

				return
			end

			ply:AddMoney(-7)
			ply:UpdateCharacterField("Money", tostring(ply:Money()))

			self:EmitSound(Sound("Buttons.snd1"))

			timer.Simple(1, function()
				if not IsValid(self) then
					return
				end

				local pos = self:GetPos() + self:GetForward() * 16 + self:GetRight() * 6 + self:GetUp() * -24
				local ang = self:GetAngles()

				ang:RotateAroundAxis(ang:Forward(), 90)

				--local ent = GAMEMODE:CreatePhysicalItem("water", pos, ang)

				self:EmitSound(Sound("Buttons.snd4"))
			end)

			if self:GetSupply() > 0 then
				self:SetSupply(self:GetSupply() - 1)
			else
				self:SetSupply(0)
			end

			net.Start("nVendingMachineUpdateSupply")
				net.WriteEntity(self)
				net.WriteInt(self:GetSupply(), 8)
			net.Broadcast()
		else
			self:EmitSound(Sound("Buttons.snd10"))
		end
	end
end

function ENT:Think()
	if CLIENT then
		return
	end

	if self:GetSupply() < 10 then
		self:SetSupply(self:GetSupply() + math.random(1, 3))

		net.Start("nVendingMachineUpdateSupply")
			net.WriteEntity(self)
			net.WriteInt(self:GetSupply(), 8)
		net.Broadcast()
	end

	self:NextThink(CurTime() + math.random(180, 300))

	return true
end

function ENT:CanPhysgun()
	return false
end

if CLIENT then
	ENT.LightMat = Material("particle/fire")

	function ENT:Draw()
		self:DrawModel()
		self:DrawShadow(true)

		local red = Color(255, 23, 23, 255)
		local green = Color(0, 255, 0, 255)

		local pos = self:GetPos() + self:GetForward() * 17.5 + self:GetRight() * -24.25 + self:GetUp() * 5
		for i = 0, 7 do
			if i == 3 then
				continue
			end

			pos = pos + self:GetUp() * -2

			render.SetMaterial(self.LightMat)
			render.DrawSprite(pos, 6, 6, red)
		end

		render.SetMaterial(self.LightMat)
		render.DrawSprite(self:GetPos() + self:GetForward() * 17.5 + self:GetRight() * -24.25 + self:GetUp() * -1, 6, 6, self:GetSupply() > 0 and green or red)
	end

	local function nVendingMachineUpdateSupply(len)
		local ent = net.ReadEntity()
		local num = net.ReadInt(8)

		if not IsValid(ent) then
			return
		end

		ent:SetSupply(num or 0)
	end

	net.Receive("nVendingMachineUpdateSupply", nVendingMachineUpdateSupply)
end