local schedule = ai_schedule.New("Control_Idle")

schedule:EngTask("TASK_WAIT", 5)

ENT:AddSchedule(schedule, function(self, interrupts)
	if interrupts.VisibleEnemy then
		self:SetCustomSchedule("Control_Attack")
	end
end)
