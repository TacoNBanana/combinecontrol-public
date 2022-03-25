AddCSLuaFile()

SWEP.PrintName 				= "GBombs Spawner"
SWEP.Author 				= "TankNut"

SWEP.RenderGroup 			= RENDERGROUP_TRANSLUCENT

SWEP.Slot 					= 3
SWEP.SlotPos 				= 4

SWEP.WorldModel 			= ""
SWEP.ViewModel 				= Model("models/weapons/c_arms.mdl")

SWEP.UseHands 				= false

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "none"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.Bombs = {
	["Davy Crockett"] = {Func = function(self, pos, radius)
		if SERVER then
			GAMEMODE:SoundRange(pos, 10000, "gbombs_5/explosions/nuclear/tsar_in.mp3")
			GAMEMODE:SoundRange(pos, 10000, "gbombs_5/explosions/nuclear/davy_explosion.mp3")
			GAMEMODE:SoundRange(pos, radius, "gbombs_5/explosions/nuclear/abomb.mp3")

			self:ShockWave(pos, radius, 800, 255)
		end
	end, Radius = 4000, Particle = "davycrockett_main"},
	["Howitzer HE"] = {Func = function(self, pos, radius)
		if SERVER then
			GAMEMODE:SoundRange(pos, 10000, "gbombs_5/explosions/light_bomb/mine_explosion.mp3")
			self:ShockWave(pos, radius, 500, 155)
		end
	end, Radius = 700, Particle = "500lb_ground"},
	["LEB- 50lb"] = {Func = function(self, pos, radius)
		if SERVER then
			GAMEMODE:SoundRange(pos, 5000, "gbombs_5/explosions/light_bomb/small_explosion_6.mp3")
			self:ShockWave(pos, radius, 99, 32)
		end
	end, Radius = 150, Particle = "50lb_main"},
	["LEB- 100lb"] = {Func = function(self, pos, radius)
		if SERVER then
			GAMEMODE:SoundRange(pos, 6000, "gbombs_5/explosions/light_bomb/small_explosion_5.mp3")
			self:ShockWave(pos, radius, 150, 75)
		end
	end, Radius = 500, Particle = "100lb_ground"},
	["170mm Tank Shell"] = {Func = function(self, pos, radius)
		if SERVER then
			GAMEMODE:SoundRange(pos, 10000, "gbombs_5/explosions/projectile/tankshell_01.wav")
			self:ShockWave(pos, radius, 200, 155)
		end
	end, Radius = 350, Particle = "high_explosive_main"},
	["GXM10 - Thermobaric"] = {Func = function(self, pos, radius)
		if SERVER then
			GAMEMODE:SoundRange(pos, 10000, "gbombs_5/explosions/heavy_bomb/ex2.mp3")
			self:ShockWave(pos, radius, 300, 500)
		end
	end, Radius = 1555, Particle = "fireboom_explosion"},
	["XMI HEB - 1000lb"] = {Func = function(self, pos, radius)
		if SERVER then
			GAMEMODE:SoundRange(pos, 10000, "gbombs_5/explosions/heavy_bomb/ex1.mp3")
			self:ShockWave(pos, radius, 300, 500)
		end
	end, Radius = 2050, Particle = "1000lb_explosion"}
}

for _, v in pairs(SWEP.Bombs) do
	PrecacheParticleSystem(v.Particle)
end

function SWEP:SetupDataTables()
	self:NetworkVar("String", 0, "Selection")
end

function SWEP:Deploy()
	if not self.Owner:IsAdmin() then
		self:Remove()
	end
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:PrimaryAttack()
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	local trace = self.Owner:GetEyeTrace()
	local pos = trace.HitPos + (trace.HitNormal * 5)

	local bomb = self.Bombs[self:GetSelection()]

	if not bomb then
		return
	end

	ParticleEffect(bomb.Particle, pos, Angle())

	bomb.Func(self, pos, bomb.Radius)

	self:SetNextPrimaryFire(CurTime() + 0.2)
end

function SWEP:SecondaryAttack()
	if CLIENT then
		local pnl = DermaMenu()

		pnl:AddOption("None", function() self:SetBomb("") end)

		for k in SortedPairs(self.Bombs) do
			pnl:AddOption(k, function() self:SetBomb(k) end)
		end

		pnl:Open(ScrW() * 0.5, ScrH() * 0.5)
	end
end

function SWEP:SetBomb(bomb)
	net.Start("nSelectBomb")
		net.WriteEntity(self)
		net.WriteString(bomb)
	net.SendToServer()
end

function SWEP:ShockWave(pos, range, damage, force)
	local ent = ents.Create("cc_shockwave")

	ent:SetPos(pos)
	ent:SetAngles(Angle())

	if range then
		ent.MaxRange = range
	end

	if damage then
		ent.Damage = damage
	end

	if force then
		ent.Force = force
	end

	ent:Spawn()
	ent:Activate()
end

function SWEP:CanSecondaryAttack()
	return true
end

function SWEP:FireAnimationEvent(pos, ang, event, name)
	return true
end

if CLIENT then
	function SWEP:PostDrawViewModel()
		if cookie.GetNumber("cc_hud", 1) != 1 then
			return
		end

		local bomb = self.Bombs[self:GetSelection()]

		if not bomb then
			return
		end

		local trace = self.Owner:GetEyeTrace()
		local pos = trace.HitPos + (trace.HitNormal * 5)

		cam.Start3D()
			render.SetColorMaterial()
			render.DrawSphere(pos, bomb.Radius, 50, 50, Color(255, 75, 75, 50))
			render.DrawWireframeSphere(pos, bomb.Radius, 50, 50, Color(255, 75, 75, 255), true)

			render.ClearStencil()
			render.SetStencilEnable(true)
				for _, v in pairs(player.GetAll()) do
					local ent = GAMEMODE:ShouldDrawStencilEnt(v)

					if not ent then
						continue
					end

					if ent:GetPos():Distance(pos) > bomb.Radius then
						continue
					end

					render.SetStencilWriteMask(255)
					render.SetStencilTestMask(255)

					render.SetStencilReferenceValue(15)

					render.SetStencilPassOperation(STENCIL_REPLACE)
					render.SetStencilFailOperation(STENCIL_KEEP)
					render.SetStencilZFailOperation(STENCIL_REPLACE)

					render.SetStencilCompareFunction(STENCIL_ALWAYS)

					render.SetBlend(0)
					GAMEMODE:DrawStencilEnt(ent)
					render.SetBlend(1)

					render.SetStencilCompareFunction(STENCIL_EQUAL)

					cam.Start2D()
						surface.SetDrawColor(255, 0, 0, 255)
						surface.DrawRect(0, 0, ScrW(), ScrH())
					cam.End2D()

					render.ClearStencil()
				end
			render.SetStencilEnable(false)
		cam.End3D()
	end
end

if SERVER then
	util.AddNetworkString("nSelectBomb")

	net.Receive("nSelectBomb", function(len, ply)
		local ent = net.ReadEntity()

		if not IsValid(ent) then
			return
		end

		if ent:GetClass() != "trp_gbombs" then
			return
		end

		if ent.Owner != ply then
			return
		end

		ent:SetSelection(net.ReadString())
	end)
end