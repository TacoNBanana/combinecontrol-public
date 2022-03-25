local schedule = ai_schedule.New("Attack")

schedule:AddTask("ConfigureAttack")
schedule:EngTask("TASK_SET_TOLERANCE_DISTANCE", 100)
schedule:EngTask("TASK_SET_ROUTE_SEARCH_TIME", 5)
schedule:EngTask("TASK_GET_PATH_TO_TARGET", 0)
schedule:EngTask("TASK_WALK_PATH", 0)
schedule:AddTask("Attack")

ENT:AddSchedule(schedule, function(self, interrupts)
	if interrupts.NoVisibleEnemy then
		self:SetCustomSchedule("Seek")
	end
end)

-- ConfigureSeek

function ENT:TaskStart_ConfigureAttack()
end

function ENT:Task_ConfigureAttack()
	local target = self:GetTarget()
	local targetMemory = self:GetMemory(target)

	if targetMemory and targetMemory.IsVisible then
		self:TaskComplete()

		return
	end

	target = nil

	for ent, memory in SortedPairsByMemberValue(self.Memories, "Distance") do
		if not memory.IsVisible then
			continue
		end

		target = ent

		break
	end

	self:SetTarget(target)
	self:TaskComplete()
end

-- Attack

local concurrent = ai.GetTaskID("TASK_WAIT")

function ENT:TaskStart_Attack()
	self:StartEngineTask(concurrent, 2)
end

function ENT:Task_Attack()
	if not self:ValidTarget(self:GetTarget()) then
		self:TaskComplete()

		return
	end

	local ent = self:GetTarget()

	local origin = self:EyePos()
	local target = ent:BodyTarget(origin)

	local bone = ent:LookupBone("ValveBiped.Bip01_Spine4")

	if bone then
		target = ent:GetBoneMatrix(bone):GetTranslation()
	end

	-- Weird that we have to do this
	self:SetMoveYawLocked(false)
	self:SetIdealYawAndUpdate((target - origin):Angle().y, -1)
	self:SetMoveYawLocked(true)

	local bullet = {}

	bullet.Num 			= 1
	bullet.Src 			= origin
	bullet.Dir 			= (target - origin):GetNormalized()
	bullet.Spread 		= self.WeaponSpread
	bullet.Damage 		= self.WeaponDamage
	bullet.TracerName 	= self.WeaponTracer

	if self.WeaponPlasma then
		GAMEMODE.PlasmaBullet = true
	end

	self:FireBullets(bullet)
	self:EmitSound(self.WeaponSound)

	GAMEMODE.PlasmaBullet = nil

	self:RunEngineTask(concurrent, 2)
end
