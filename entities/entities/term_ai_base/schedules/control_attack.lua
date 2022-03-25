local schedule = ai_schedule.New("Control_Attack")

schedule:AddTask("ConfigureAttack")
schedule:AddTask("Attack")

ENT:AddSchedule(schedule, function(self, interrupts)
	if interrupts.NoVisibleEnemy then
		self:SetCustomSchedule("Control_Idle")
	end
end)
