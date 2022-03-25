local schedule = ai_schedule.New("Control_MoveTo")

schedule:EngTask("TASK_SET_TOLERANCE_DISTANCE", 1000)
schedule:EngTask("TASK_SET_ROUTE_SEARCH_TIME", 5)
schedule:EngTask("TASK_GET_PATH_TO_SAVEPOSITION", 0)
schedule:EngTask("TASK_WALK_PATH", 0)

ENT:AddSchedule(schedule, function(self, interrupts)
end)
