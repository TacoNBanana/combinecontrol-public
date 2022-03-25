AddCSLuaFile()

ENT.Base 				= "cc_m203"

ENT.Model 				= Model("models/items/ar2_grenade.mdl")

ENT.Velocity 			= 4000

ENT.UseGravity 			= true
ENT.GravityMultiplier 	= 1

ENT.Damage 				= 2000
ENT.Radius 				= 200

if SERVER then
	function ENT:CustomInit()
		self:SetNoDraw(true)

		local trail = ents.Create("env_spritetrail") -- Tracer streak
		trail:SetKeyValue("lifetime","0.2")
		trail:SetKeyValue("startwidth","34")
		trail:SetKeyValue("endwidth","5")
		trail:SetKeyValue("spritename","trails/laser.vmt")
		trail:SetKeyValue("rendermode","2")
		trail:SetKeyValue("rendercolor","255 150 100")
		trail:SetPos(self:GetPos())
		trail:SetParent(self)
		trail:Spawn()
		trail:Activate()

		local glow = ents.Create("env_sprite") -- Bullet glow
		glow:SetKeyValue("model","orangecore2.vmt")
		glow:SetKeyValue("rendercolor","255 150 100")
		glow:SetKeyValue("scale","0.064")
		glow:SetPos(self:GetPos())
		glow:SetParent(self)
		glow:Spawn()
		glow:Activate()

		local shine = ents.Create("env_sprite") -- ??
		shine:SetPos(self:GetPos())
		shine:SetKeyValue("renderfx", "0")
		shine:SetKeyValue("rendermode", "5")
		shine:SetKeyValue("renderamt", "255")
		shine:SetKeyValue("rendercolor", "255 130 100")
		shine:SetKeyValue("framerate12", "20")
		shine:SetKeyValue("model", "light_glow03.spr")
		shine:SetKeyValue("scale", "0.16")
		shine:SetKeyValue("GlowProxySize", "26")
		shine:SetParent(self)
		shine:Spawn()
		shine:Activate()
	end

	function ENT:OnHit(data)
		local ent = data.Entity
		local pos = self:GetPos()

		if IsValid(ent) and ent:IsPlayer() then
			local info = DamageInfo()

			info:SetDamage(self.Damage * 2)
			info:SetAttacker(self:GetOwner())
			info:SetInflictor(self)
			info:SetDamageType(DMG_BLAST)

			ent:TakeDamageInfo(info)
		end

		util.ScreenShake(pos, 25, 150, 1, self.Radius)

		local explo = ents.Create("env_ar2explosion")
		explo:SetOwner(self:GetOwner())
		explo:SetPos(pos)
		explo:SetKeyValue("iMagnitude", self.Damage)
		explo:SetKeyValue("iRadiusOverride", self.Radius)
		explo:SetKeyValue("SpawnFlags", 336)
		explo:Spawn()
		explo:Activate()
		explo:Fire("Explode")

		GAMEMODE:SoundRange(pos, self.Radius, "ambient/levels/labs/electric_explosion3.wav", 0.5)
	end
end