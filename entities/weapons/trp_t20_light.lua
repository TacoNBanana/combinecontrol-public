AddCSLuaFile()

SWEP.PrintName 				= "Base"
SWEP.Author 				= "TankNut"

SWEP.RenderGroup 			= RENDERGROUP_TRANSLUCENT

SWEP.DrawCrosshair 			= false

SWEP.PrintName 				= "T-20 Light"
SWEP.Category 				= "TRP - Drones"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.Slot 					= 2
SWEP.SlotPos 				= 12

SWEP.ViewModel 				= Model("models/weapons/c_arms_citizen.mdl")
SWEP.WorldModel 			= "models/props_lab/cactus.mdl"

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "none"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

function SWEP:Initialize()
	if CLIENT then
		self.PixVis = util.GetPixelVisibleHandle()
	end

	self:SetColor(Color(255, 210, 40))
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "On")
end

function SWEP:PrimaryAttack()
	if CLIENT then
		return
	end

	if self:GetOn() then
		self:TurnOff()
	else
		self:TurnOn()
	end

	self:GetOwner():EmitSound("buttons/lightswitch2.wav", 70, 100, 0.5)
	self:SetNextPrimaryFire(CurTime() + 0.1)
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
	local ply = self:GetOwner()

	if IsValid(ply) and IsValid(self.Light) then
		self.Light:SetPos(ply:EyePos())
		self.Light:SetAngles(ply:EyeAngles())
	end
end

function SWEP:TurnOn()
	local ply = self:GetOwner()

	self:SetOn(true)

	SafeRemoveEntity(self.Light)

	self.Light = ents.Create("env_projectedtexture")

	self.Light:SetPos(ply:EyePos())
	self.Light:SetAngles(ply:EyeAngles())

	self.Light:SetKeyValue("enableshadows", 1)
	self.Light:SetKeyValue("lightfov", 90)

	self.Light:SetKeyValue("nearz", 30)
	self.Light:SetKeyValue("farz", 1024)

	self.Light:SetKeyValue("lightcolor", ply:Team() == TEAM_SKYNET and "255 0 0 100" or "0 128 255 100")

	self.Light:Spawn()
	self.Light:Input("SpotlightTexture", NULL, NULL, "effects/flashlight001")

	self:DeleteOnRemove(self.Light)
end

function SWEP:TurnOff()
	self:SetOn(false)

	SafeRemoveEntity(self.Light)
end

function SWEP:OnRemove()
	self:TurnOff()
end

function SWEP:Holster()
	self:TurnOff()

	return true
end

if CLIENT then
	local mat = Material("sprites/light_ignorez")

	local skynet = Color(255, 0, 0)
	local reprog = Color(0, 161, 255)

	function SWEP:DrawWorldModelTranslucent()
		if not self:GetOn() then
			return
		end

		local ply = self:GetOwner()
		local bone = ply:LookupBone("Antlion_Guard.body")

		local dir = ply:GetRenderAngles()

		dir.p = 0
		dir = -dir:Forward()

		local eye = (self:GetPos() - EyePos()):GetNormalized()
		local dist = eye:Length()

		local dot = eye:Dot(dir)

		if bone then
			local matrix = ply:GetBoneMatrix(bone)

			if not matrix then
				return
			end

			local pos = LocalToWorld(Vector(-1.9, 14, 0), angle_zero, matrix:GetTranslation(), matrix:GetAngles())
			local vis = util.PixelVisible(pos, 16, self.PixVis)

			if dot >= 0 and vis > 0 then
				render.SetMaterial(mat)

				local size = math.Clamp(dist * vis * dot * 2, 64, 128)

				dist = math.Clamp(dist, 32, 800)

				local alpha = math.Clamp((1000 - dist) * vis * dot, 0, 255)

				render.DrawSprite(pos, size * 0.4, size * 0.4, ColorAlpha(ply:Team() == TEAM_SKYNET and skynet or reprog, alpha), vis * dot)
			end
		end
	end
end
