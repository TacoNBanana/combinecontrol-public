local schedule = ai_schedule.New("Wander")

schedule:EngTask("TASK_SET_TOLERANCE_DISTANCE", 48)
schedule:EngTask("TASK_SET_ROUTE_SEARCH_TIME", 5)
schedule:EngTask("TASK_GET_PATH_TO_RANDOM_NODE", 600)
schedule:EngTask("TASK_WALK_PATH", 0)
schedule:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)

ENT:AddSchedule(schedule, function(self, interrupts)
	if interrupts.VisibleEnemy then
		self:SetCustomSchedule("Seek")
	end
end)
