INTERRUPT_TEST = 0

function ENT:QueueInterrupt(interrupt)
	self.Interrupts[interrupt] = true
end

function ENT:IsInterruptSet(interrupt)
	return tobool(self.Interrupts[interrupt])
end

function ENT:FireInterrupts()
	if not self.InterruptHandler then
		return
	end

	self:InterruptHandler(self.Interrupts)

	table.Empty(self.Interrupts)
end
