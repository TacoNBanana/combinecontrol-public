AddCSLuaFile()

ENT.Base 		= "cc_base_ent"

ENT.BeepSound 	= Sound("buttons/button17.wav")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
end

function ENT:Initialize()
	self:SetModel(Model("models/weapons/w_slam.mdl"))
	self:EmitSound("buttons/combine_button_locked.wav")

	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end
end

function ENT:Use(activator, caller, usetype, value)
	if CLIENT then
		return
	end

	-- TODO: Move the beeping clientside, add a flashing sprite or dynlight?
	self:SetActivated(true)
	self:EmitSound(self.BeepSound)

	local delay = 1.25
	local name = "BreachCharge_" .. self:EntIndex()

	local function f()
		if not IsValid(self) or not IsValid(self.Door) then
			timer.Remove(name)

			return
		end

		delay = delay * 0.8

		if delay < 0.03 then
			self.Door:SetDoorIsPlanted(0)

			GAMEMODE:ExplodeDoor(self.Door, self:GetUp() * -64, true)

			self:Remove()

			return
		else
			self:EmitSound(self.BeepSound)

			timer.Adjust(name, delay, 0, f)
		end
	end

	timer.Create(name, delay, 0, f)
end