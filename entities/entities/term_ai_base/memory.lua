function ENT:WipeMemory()
	table.Empty(self.Memories)
end

function ENT:ClearMemory(ent)
	self.Memories[ent] = nil
end

function ENT:HasMemory(ent)
	return tobool(self.Memories[ent])
end

function ENT:HasActiveMemory(ent)
	local memory = self:GetMemory(ent)

	if not memory then
		return false
	end

	return CurTime() - memory.LastSeen <= self.ActiveMemoryTime
end

function ENT:GetMemory(ent)
	return self.Memories[ent]
end

function ENT:UpdateMemory(ent, pos)
	if not self.Memories[ent] then
		self.Memories[ent] = {
			LastPos = pos,
			LastSeen = CurTime(),
			LastTick = engine.TickCount(),
			Distance = self:EyePos():Distance(pos),
			IsVisible = true
		}

		return true
	end

	local memory = self.Memories[ent]

	memory.LastPos = pos
	memory.LastSeen = CurTime()
	memory.LastTick = engine.TickCount()
	memory.Distance = self:EyePos():Distance(pos)
	memory.IsVisible = true

	return false
end

function ENT:UpdateMemories()
	local tick = engine.TickCount()

	for ent, memory in pairs(self.Memories) do
		if not self:ValidTarget(ent) then
			self.Memories[ent] = nil

			continue
		end

		if CurTime() - memory.LastSeen > self.InactiveMemoryTime then
			self.Memories[ent] = nil

			continue
		end

		if memory.LastTick < tick then
			memory.IsVisible = false
		end
	end

	self:QueueInterrupt(table.IsEmpty(self.Memories) and "NoMemories" or "HasMemories")
end
