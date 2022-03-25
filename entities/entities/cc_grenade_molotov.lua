AddCSLuaFile()

ENT.Base 	= "cc_grenade_frag"

ENT.Model 	= Model("models/props_junk/garbage_glassbottle003a.mdl")

function ENT:OnTakeDamage(dmginfo)
	self:Detonate()
end

function ENT:PhysicsCollide(data, phys)
	if data.HitEntity and data.HitEntity:IsValid() then

		if data.HitEntity:GetClass() == "func_breakable" or data.HitEntity:GetClass() == "func_breakable_surf" then

			data.HitEntity:Fire("Break")
			data.HitEntity.Broken = true
			phys:SetVelocity(data.OurOldVelocity)
			return

		end

		if data.HitEntity.Broken then return end

	end

	self:Detonate()
end

function ENT:Explode(tr)
	if tr.Fraction != 1.0 then
		self:SetPos(tr.HitPos + tr.Normal * 0.6)
	end

	self:EmitSound(Sound("physics/glass/glass_bottle_break" .. math.random(1, 2) .. ".wav"))
	self:EmitSound(Sound("ambient/fire/ignite.wav"))
	self:MakeFire()

	SafeRemoveEntityDelayed(self, 0)
end

function ENT:MakeFire()
	if vFireInstalled then
		local pos = self:GetPos()

		timer.Simple(0, function()
			for i = 1, 20 do
				CreateVFireBall(10, 20, pos + Vector(0, 0, 1), VectorRand() * 300, self)
			end
		end)
	else
		for i = 1, 15 do
			local a = math.Rand(0, 2 * math.pi)
			local s = math.sin(a)
			local c = math.cos(a)
			local r = math.random(0, 256)

			local x = c * r
			local y = s * r

			local trace = {}
			trace.start = self:GetPos()
			trace.endpos = trace.start + Vector(x, y, 48)
			trace.filter = self
			local tr = util.TraceLine(trace)

			if not tr.Hit then

				local trace = {}
				trace.start = tr.HitPos
				trace.endpos = trace.start + Vector(0, 0, -32768)
				trace.filter = self
				tr = util.TraceLine(trace)

			end

			local del = math.Rand(0, 1)

			local fireEnt = ents.Create("env_fire")
			fireEnt:SetPos(tr.HitPos)
			fireEnt:SetKeyValue("spawnflags", "1")
			fireEnt:SetKeyValue("attack", "4")
			fireEnt:SetKeyValue("firesize", "128")
			fireEnt:Spawn()
			fireEnt:Activate()
			fireEnt:Fire("Enable", "", del)
			fireEnt:Fire("StartFire", "", del)

			SafeRemoveEntityDelayed(fireEnt, math.random(28, 35))
		end
	end
end
