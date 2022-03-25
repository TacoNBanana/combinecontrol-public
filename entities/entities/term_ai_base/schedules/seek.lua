local schedule = ai_schedule.New("Seek")

schedule:AddTask("ConfigureSeek")
schedule:EngTask("TASK_SET_TOLERANCE_DISTANCE", 48)
schedule:EngTask("TASK_SET_ROUTE_SEARCH_TIME", 5)
schedule:EngTask("TASK_GET_PATH_TO_SAVEPOSITION", 0)
schedule:EngTask("TASK_WALK_PATH", 0)
schedule:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
schedule:AddTask("FinishSeek")

ENT:AddSchedule(schedule, function(self, interrupts)
	if interrupts.VisibleEnemy then
		self:SetCustomSchedule("Attack")
	elseif interrupts.NoMemories then
		self:SetCustomSchedule("Wander")
	end
end)

-- ConfigureSeek

function ENT:TaskStart_ConfigureSeek()
end

function ENT:Task_ConfigureSeek()
	for ent, memory in SortedPairsByMemberValue(self.Memories, "Distance", true) do
		self:SetSaveValue("m_vSavePosition", memory.LastPos)
		self.ActiveMemory = ent

		break
	end

	self:TaskComplete()
end

-- FinishSeek

function ENT:TaskStart_FinishSeek()
	-- Todo: Only clear memory when we've reached the target
	self:ClearMemory(self.ActiveMemory)
	self:TaskComplete()
end

function ENT:Task_FinishSeek()
end
