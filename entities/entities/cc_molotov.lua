AddCSLuaFile()

ENT.Base = "cc_base_ent"

function ENT:Initialize()
	if CLIENT then
		return
	end

	self:SetModel(Model("models/props_junk/garbage_glassbottle003a.mdl"))
	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
	end
end

function ENT:OnTakeDamage(dmginfo)
	self:Detonate()
end

function ENT:PhysicsCollide(data, phys)
	local ent = data.HitEntity

	if IsValid(ent) then
		if ent:GetClass() == "func_breakable" or ent:GetClass() == "func_breakable_surf" then
			ent:Fire("Break")
			ent.Broken = true

			phys:SetVelocity(data.OurOldVelocity)

			return
		end

		if data.HitEntity.Broken then
			return
		end
	end

	self:Detonate()
end

function ENT:Detonate()
	self:NextThink(CurTime() + 1)

	self:EmitSound("physics/glass/glass_bottle_break" .. math.random(1, 2) .. ".wav")
	self:EmitSound("ambient/fire/ignite.wav")
	self:MakeFire()

	self:Remove()
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