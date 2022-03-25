AddCSLuaFile()

SWEP.PrintName 				= "Zombie marker"
SWEP.Slot 					= 3
SWEP.SlotPos 				= 4

SWEP.UseHands 				= false
SWEP.ViewModel 				= "models/weapons/c_arms.mdl"
SWEP.WorldModel 			= ""

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Ammo			= ""
SWEP.Primary.Automatic 		= false

SWEP.Secondary.ClipSize 	= 1
SWEP.Secondary.DefaultClip 	= 1
SWEP.Secondary.Ammo			= ""
SWEP.Secondary.Automatic 	= false

function SWEP:SetupDataTables()
	self:NetworkVar("Vector", 0, "NWCorner")
	self:NetworkVar("Vector", 1, "NECorner")
	self:NetworkVar("Vector", 2, "SWCorner")
	self:NetworkVar("Vector", 3, "SECorner")
	self:NetworkVar("Vector", 4, "AreaCenter")

	self:NetworkVar("Int", 0, "AreaID")
	self:NetworkVar("Int", 1, "ZombieAmount")

	self:NetworkVar("Bool", 0, "Spawning")
end

function SWEP:Initialize()
	if SERVER and not navmesh.IsLoaded() then
		self:Remove()
	end
end

function SWEP:Deploy()
	self:SetHoldType("normal")
	self:SetAreaID(-1)
end

function SWEP:PrimaryAttack()
	local id = self:GetAreaID()

	if SERVER and id != -1 then
		GAMEMODE:ToggleSpawner(id)

		self:SetSpawning(not self:GetSpawning())
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
	local ply = self.Owner

	if SERVER then
		local area = navmesh.GetNearestNavArea(ply:GetEyeTrace().HitPos, false, 100, true)

		if IsValid(area) then
			local id = self:GetAreaID()
			local areaid = area:GetID()

			if id != areaid then
				self:SetAreaID(areaid)

				self:SetNWCorner(area:GetCorner(0))
				self:SetNECorner(area:GetCorner(1))
				self:SetSWCorner(area:GetCorner(2))
				self:SetSECorner(area:GetCorner(3))

				self:SetAreaCenter(area:GetCenter())

				self:SetSpawning(GAMEMODE:Spawners()[areaid] or false)
				self:SetZombieAmount(GAMEMODE:GetZombieAmount(area))
			end
		else
			self:SetAreaID(-1)
		end
	end
end

if CLIENT then
	function SWEP:DrawArea(q1, q2, q3, q4, color, center, count)
		render.SetColorMaterialIgnoreZ()

		render.DrawQuad(q1, q2, q3, q4, color)
		render.DrawQuad(q2, q1, q4, q3, color)

		local pos = (center + Vector(0, 0, 10)):ToScreen()

		cam.Start2D()
			draw.DrawText(count, "BudgetLabel", pos.x, pos.y, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		cam.End2D()
	end

	function SWEP:DrawHUDBackground()
		local id = self:GetAreaID()

		cam.Start3D(EyePos(), EyeAngles())
			for k, v in pairs(GAMEMODE:Spawners()) do
				if k == id then
					continue
				end

				self:DrawArea(v[1], v[2], v[3], v[4], Color(220, 0, 255, 100), v[5], v[6])
			end

			if id != -1 then
				local q1, q2, q3, q4 = self:GetNWCorner(), self:GetNECorner(), self:GetSWCorner(), self:GetSECorner()
				local color = self:GetSpawning() and Color(255, 255, 255, 100) or Color(255, 0, 0, 100)

				self:DrawArea(q1, q2, q3, q4, color, self:GetAreaCenter(), self:GetZombieAmount())
			end
		cam.End3D()
	end
end