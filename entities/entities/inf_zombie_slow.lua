AddCSLuaFile()

ENT.Base 			= "base_nextbot"

ENT.PrintName 		= "Zombie (slow)"
ENT.Category 		= "CombineControl"

ENT.Spawnable 		= true
ENT.AdminSpawnable 	= true

ENT.SlowZombie 		= true

if CLIENT then
	language.Add("inf_zombie_slow", "Zombie (slow)")
end

function ENT:CanPhysgun(ply)
	return ply:IsAdmin()
end

function ENT:Initialize()
	if CLIENT then return end

	self.Sex = (math.random(0, 1) == 0) and MALE or FEMALE

	self:SetModel(table.Random(table.GetKeys(GAMEMODE.SurvivorModels[self.Sex])))

	self:SetFacemapMat("infected/humans/" .. string.StripExtension(string.GetFileFromFilename(self:GetModel())) .. "/facemap_infected")
	self:SetClothesSheetMat(table.Random( GAMEMODE.InfectedClothes[self.Sex]))

	self:SetSubMaterial(self:GetFacemap(), self:GetFacemapMat())
	self:SetSubMaterial(self:GetClothesSheet(), self:GetClothesSheetMat())

	self:SetHealth(math.random(160, 260))

	self.WanderAttentionSpan = math.Rand(3, 9)
	self.ChaseAttentionSpan = math.Rand(20, 60)

	if self.SlowZombie then
		self.ChaseAttentionSpan = math.Rand(200, 300)
	else
		self.ChaseAttentionSpan = math.Rand(20, 60)
	end

	self.WalkAct = math.random(1628, 1631)

	self.PlayerPositions = {}
end

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "FacemapMat")
	self:NetworkVar("String", 1, "ClothesSheetMat")
end

function ENT:BehaveAct()
end

function ENT:Think()
end

function ENT:BodyUpdate()
	self:BodyMoveXY()
end

function ENT:CanTarget(ply)
	return ply:Alive() and (ply:InVehicle() or ply:GetMoveType() ~= MOVETYPE_NOCLIP)
end

function ENT:MovementThink()
	if self.loco:IsStuck() then
		self.StuckTime = self.StuckTime or CurTime()
		self:Attack()
	else
		self.StuckTime = nil
	end

	if self.StuckTime and CurTime() >= self.StuckTime + 60 then
		self:Remove()

		return
	end

	local trace = {}

	trace.start = self:WorldSpaceCenter()
	trace.endpos = trace.start + self:GetForward() * 64
	trace.filter = self

	local tr = util.TraceLine(trace)

	if IsValid(tr.Entity) then
		if tr.Entity:GetClass() == "func_breakable" or tr.Entity:GetClass() == "func_breakable_surf" then
			self:Attack()
		end

		if tr.Entity:GetClass() == "prop_door_rotating" or tr.Entity:GetClass() == "func_door_rotating" then
			self:Attack()
		end
	end
end

function ENT:AttackThink()
	if self.NextAttackDamage and CurTime() > self.NextAttackDamage then
		self.NextAttackDamage = nil

		local venttab = {}

		for _, v in pairs(ents.FindInSphere(self:GetPos(), 70)) do
			local trace = {}

			trace.start = self:WorldSpaceCenter()
			trace.endpos = v:WorldSpaceCenter()
			trace.filter = ents.FindByClass("inf_zombie*")

			local tr = util.TraceLine(trace)

			if IsValid(tr.Entity) and tr.Entity == v then
				table.insert(venttab, v)
			end
		end

		for _, v in pairs(venttab) do
			if v:IsPlayer() and not self:CanTarget(v) then
				continue
			end

			if v:IsPlayer() and self:IsOnFire() and not v:IsOnFire() then
				v:Ignite(20, 0)
			end

			local dmg = DamageInfo()

			dmg:SetAttacker(self)
			dmg:SetDamage(20)
			dmg:SetDamageType(DMG_CLUB)
			dmg:SetInflictor(self)

			v:TakeDamageInfo(dmg)

			if v:GetClass() == "func_breakable_surf" then
				v:Fire("Shatter", "0 0 0")
			end

			local ply = false

			for _, n in pairs(player.GetAll()) do
				if n:GetPos():Distance(v:GetPos()) < 1500 then
					ply = true
				end
			end

			if v:IsDoor() and ply and math.random(1, 8) == 1 then
				local d = (v:GetPos() - self:GetPos()):GetNormal()

				GAMEMODE:ExplodeDoor(v, d * 50)
			end
		end

		if #venttab > 0 then
			self:EmitSound("infected/zombie/attack/hit_0" .. math.random(1, 8) .. ".wav")
		end
	end
end

function ENT:IdleThink()
	self.NextIdleSound = self.NextIdleSound or CurTime()

	if CurTime() >= self.NextIdleSound then
		local snd = "infected/zombie/idle/idle_" .. string.FormatDigits(math.random(1, 31)) .. ".wav"

		self:EmitSound(snd)

		self.NextIdleSound = CurTime() + SoundDuration(snd) + math.random(6, 12)
	end
end

function ENT:RageThink()
	if self.SlowZombie then
		self:IdleThink()

		return
	end

	self.NextRageSound = self.NextRageSound or CurTime()

	if CurTime() >= self.NextRageSound then
		local g = (self.Sex == FEMALE) and "female" or "male"

		local snd = "infected/zombie/rage/" .. g .. "/rage_" .. string.FormatDigits(math.random(1, 32)) .. ".wav"

		self:EmitSound(snd)

		self.NextRageSound = CurTime() + SoundDuration(snd) + math.random(3, 8)
	end
end

function ENT:StuckThink()
end

function ENT:Attack()
	self.NextAttack = self.NextAttack or CurTime()

	if CurTime() >= self.NextAttack then
		self:RestartGesture(ACT_GMOD_GESTURE_RANGE_ZOMBIE)

		self.NextAttack = CurTime() + 1.6
		self.NextAttackDamage = CurTime() + 0.6

		self:EmitSound("infected/zombie/attack/swing_0" .. math.random(1, 2) .. ".wav")
	end
end

function ENT:Wander(rad)
	local r = math.random(0, 360)

	local x = math.cos(r) * rad
	local y = math.sin(r) * rad

	local path = Path("Follow")

	path:SetMinLookAheadDistance(0)
	path:SetGoalTolerance(60)
	path:Compute(self, self:GetPos() + Vector(x, y, 0))

	if not path:IsValid() then
		return "failed"
	end

	while path:IsValid() do
		path:Update(self)

		--path:Draw();

		self:AttackThink()
		self:IdleThink()
		self:MovementThink()

		self:UpdatePlayerPositions()

		local ret, ply = self:GetBestEnemy()

		if ret then
			return "found", ply
		end

		if self.loco:IsStuck() and self:HandleStuck() then
			return "stuck"
		end

		if path:GetAge() > self.WanderAttentionSpan then
			return "timeout"
		end

		coroutine.yield()
	end

	return "ok"
end

function ENT:Idle(delay)
	local t = CurTime() + delay

	self:SetSequence(self:LookupSequence( "zombie_idle_01"))

	self:ResetSequenceInfo()
	self:SetCycle(0)
	self:SetPlaybackRate(1)

	while CurTime() < t do
		self:AttackThink()
		self:IdleThink()

		self:UpdatePlayerPositions()

		local ret, ply = self:GetBestEnemy()

		if ret then
			return "found", ply
		end

		coroutine.yield()
	end
end

function ENT:FindClosestPlayer()
	local closest = nil
	local dist = math.huge

	for _, v in pairs(player.GetAll()) do
		if not v:IsZombie() then
			local d = v:GetPos():Distance(self:GetPos())

			if d < dist then
				dist = d
				closest = v
			end
		end
	end

	return closest, dist;
end

function ENT:FindClosestPlayerDistance()
	local dist = math.huge

	for _, v in pairs(player.GetAll()) do
		if not v:IsZombie() then
			local d = v:GetPos():Distance(self:GetPos())

			if d < dist then
				dist = d
			end
		end
	end

	return dist
end

function ENT:FindClosestPlayerMemory()
	local closest = nil
	local dist = math.huge

	for k, v in pairs(self.PlayerPositions) do
		if not v:IsZombie() then
			local d = v:Distance(self:GetPos())

			if d < dist then
				dist = d
				closest = k
			end
		end
	end

	return closest, dist
end

function ENT:ChasePlayer()
	if not IsValid(self.Target) then
		return "no target"
	end

	if not self.PlayerPositions[self.Target] then
		return "no player position"
	end

	local path = Path("Follow")

	path:SetMinLookAheadDistance(0)
	path:SetGoalTolerance(20)
	path:Compute(self, self.PlayerPositions[self.Target][1])

	if not path:IsValid() then
		return "failed"
	end

	while path:IsValid() do
		if not IsValid(self.Target) then
			return "lost target"
		end

		path:Update(self)

		--path:Draw();

		self:AttackThink()
		self:MovementThink()
		self:RageThink()

		local dist = (self.PlayerPositions[self.Target][1] - self:GetPos()):Length()

		if dist > 1500 and path:GetAge() > 1 then
			if self.PlayerPositions[self.Target] then
				path:Compute(self, self.PlayerPositions[self.Target][1])
			end

		elseif dist <= 1500 and path:GetAge() > 0.3 then
			if self.PlayerPositions[self.Target] then
				path:Compute( self, self.PlayerPositions[self.Target][1])
			end
		end

		if self:FindClosestPlayerDistance() < 64 then
			self:Attack()
		end

		self:UpdatePlayerPositions()

		local ret, ply = self:GetBestEnemy()

		if ret then -- we have no enemy to chase..
			self.Target = ply
		else
			return "lost targets"
		end

		coroutine.yield()
	end

	return "ok"
end

function ENT:UpdatePlayerPositions()
	for k, v in pairs(self.PlayerPositions) do
		if IsValid(k) then
			self.PlayerPositions[k] = nil

			if k == self.Target then
				self.Target = nil
			end
		elseif not k:Alive() then
			self.PlayerPositions[k] = nil

			if k == self.Target then
				self.Target = nil
			end
		elseif CurTime() > v[2] + self.ChaseAttentionSpan then
			self.PlayerPositions[k] = nil

			if k == self.Target then
				self.Target = nil
			end
		end
	end

	for _, v in pairs(player.GetAll()) do
		if not self:CanTarget(v) then
			continue
		end

		if v:IsZombie() then
			continue
		end

		local pos = v:GetPos()
		local d = self:GetPos():Distance(pos)

		if self.LastShot and self.LastShot == v then
			self.PlayerPositions[v] = {pos, CurTime()}

			continue
		end

		if d < 400 and v:FlashlightIsOn() then
			self.PlayerPositions[v] = {pos, CurTime()}

			continue
		end

		if d < 200 and (not v:Crouching() or v:FlashlightIsOn()) then
			self.PlayerPositions[v] = {pos, CurTime()}

			continue
		end

		local dot = (pos - self:GetPos()):GetNormal():Dot(self:GetForward())

		if v:Crouching() and not v:FlashlightIsOn() then
			if self:CanSee(v) and dot > 0.7 and d < 1000 then
				self.PlayerPositions[v] = {pos, CurTime()}
			end
		else
			if self.PlayerPositions[v] and d < 700 then
				self.PlayerPositions[v] = {pos, CurTime()}
			elseif self:CanSee(v) and dot > 0.6 and d < 2000 then
				self.PlayerPositions[v] = {pos, CurTime()}
			end
		end
	end
end

function ENT:PathDistanceToPos(pos)
	if true then
		return (self:GetPos() - pos):Length()
	else
		local path = Path("Follow")

		path:SetMinLookAheadDistance(0)
		path:SetGoalTolerance(20)
		path:Compute(self, pos)

		return path:GetLength()
	end
end

function ENT:GetBestEnemy()
	if IsValid(self.Target) and self.PlayerPositions[self.Target] then
		local d = self:PathDistanceToPos(self.PlayerPositions[self.Target][1])

		if IsValid(self.LastShot) then
			self.LastShot = nil

			if d > 400 then
				return true, self.LastShot
			end
		end

		for k, v in pairs(self.PlayerPositions) do
			local l = self:PathDistanceToPos(v[1])

			if l < d then
				return true, k
			end
		end

		return nil, self.Target
	else

		if IsValid(self.LastShot) then
			self.LastShot = nil

			return true, self.LastShot
		end

		local d = math.huge
		local ply = nil

		for k, v in pairs(self.PlayerPositions) do
			local l = self:PathDistanceToPos(v[1])

			if l < d then
				d = l
				ply = k
			end
		end

		if ply then
			return true, ply
		else
			return false, nil
		end
	end
end

function ENT:OnInjured(dmg)
	local ent = dmg:GetAttacker()

	local z = (dmg:GetDamagePosition() - self:GetPos()).z

	if self.SlowZombie then
		if z > 55 then
			dmg:ScaleDamage(2.25)
		else
			dmg:ScaleDamage(0.4)

			if IsValid(ent) and ent:IsPlayer() then
				self.LastShot = ent
			end
		end
	else
		if IsValid(ent) and ent:IsPlayer() then
			self.LastShot = ent

			if not self.PlayerPositions[ent] then
				dmg:ScaleDamage(10)
			end
		end

		if z > 60 then
			dmg:ScaleDamage(2)
		end
	end
end

function ENT:OnKilled(dmg)
	hook.Run("OnNPCKilled", self, dmg:GetAttacker(), dmg:GetInflictor())

	net.Start("nZombieDeath")
		net.WriteEntity(self)
	net.Broadcast()

	self:Remove()
end

function ENT:RunBehaviour()
	while true do
		self:StartActivity(self.WalkAct)
		self.loco:SetDesiredSpeed(40)

		local ret, ply = self:Wander(300)

		if ret == "found" then
			self.Target = ply

			if self.SlowZombie then
				self:StartActivity(self.WalkAct)
				self.loco:SetDesiredSpeed(40)
			else
				self:StartActivity(ACT_HL2MP_RUN_FAST)
				self.loco:SetDesiredSpeed(220)
			end

			self:ChasePlayer(ply)
		end

		ret, ply = self:Idle(math.Rand(5, 15))

		if ret == "found" then
			self.Target = ply

			if self.SlowZombie then
				self:StartActivity(self.WalkAct)
				self.loco:SetDesiredSpeed(40)
			else
				self:StartActivity(ACT_HL2MP_RUN_FAST)
				self.loco:SetDesiredSpeed(220)
			end

			self:ChasePlayer()
		end

		local plys = ents.FindInSphere(self:GetPos(), 400)
		local idlemore = true
		local n = false

		for _, v in pairs(plys) do
			if v:IsPlayer() and self:CanTarget(v) then
				if not v:Crouching() then
					idlemore = false
				end

				n = true
			end
		end

		if not n then
			idlemore = false
		end

		if idlemore then
			ret, ply = self:Idle(math.Rand(10, 15))

			if ret == "found" then
				self.Target = ply

				if self.SlowZombie then
					self:StartActivity(self.WalkAct)
					self.loco:SetDesiredSpeed(40)
				else
					self:StartActivity(ACT_HL2MP_RUN_FAST)
					self.loco:SetDesiredSpeed(220)
				end

				self:ChasePlayer()
			end
		end

		coroutine.yield()
	end
end

if CLIENT then
	net.Receive("nZombieDeath", function()
		local ent = net.ReadEntity()

		if IsValid(ent) then
			local ragdoll = ent:BecomeRagdollOnClient()

			if IsValid(ragdoll) then
				ragdoll:CopyBodygroups(ent)
				ragdoll:SetSubMaterial(ent:GetFacemap(), ent:GetFacemapMat())
				ragdoll:SetSubMaterial(ent:GetClothesSheet(), ent:GetClothesSheetMat())

				timer.Simple(math.random(60, 120), function()
					if not IsValid(ragdoll) then return end

					ragdoll:SetSaveValue("m_bFadingOut", true)
				end)
			end
		end
	end)
end