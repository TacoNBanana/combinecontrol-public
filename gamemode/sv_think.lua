function GM:Think()
	for _, v in pairs(player.GetAll()) do
		hook.Run("CC.SV.PlayerThink", v)
	end

	self:SQLThink()
	self:SpawnerThink()
	self:CombineCameraThink()
	self:LootThink()

	hook.Run("CC.SH.Think")
end

GM.LootData = GM.LootData or {
	Entities = {},
	Disabled = {},
	Time = {}
}

function GM:LootThink()
	if not self.Loot.Enabled then
		return
	end

	local playercount = #player.GetAll()
	local max = game.MaxPlayers()

	for pool, v in pairs(self.Loot.Pools) do
		local rates = self.Loot.Rates[pool]

		if not rates then
			continue
		end

		local delete = playercount < rates[1]

		self.LootData.Disabled[pool] = delete

		if delete then
			self.LootData.Time[pool] = nil

			continue
		end

		local time = self.LootData.Time[pool]
		local cooldown = math.Remap(playercount, playercount, max, rates[2], rates[3])

		if not time then
			self.LootData.Time[pool] = CurTime()

			continue
		end

		if time + cooldown >= CurTime() then
			continue
		end

		self.LootData.Time[pool] = CurTime()

		if not self.LootData.Entities[pool] then
			continue
		end

		local _, ent = table.Random(self.LootData.Entities[pool])

		if not ent then
			continue
		end

		local choice = table.WeightedRandom(v)

		while choice and not self.ItemClasses[choice] do
			local new = self.Loot.Pools[choice]

			if not new then
				choice = nil

				continue
			end

			choice = table.WeightedRandom(new)
		end

		if not choice then
			continue
		end

		ent.StoredItem = choice
	end
end