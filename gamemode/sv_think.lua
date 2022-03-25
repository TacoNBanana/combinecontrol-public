function GM:Think()
	for _, v in pairs(player.GetAll()) do
		hook.Run("CC.SV.PlayerThink", v)
		hook.Run("PlayerThink", v)
	end

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

GM.LootStats = GM.LootStats or {
	Players = {}
}

function GM:ResolveLoot(pool, poolsOnly)
	if isstring(pool) then
		pool = self.Loot.Pools[pool]
	end

	if not pool then
		return
	end

	local choice = table.WeightedRandom(pool)

	if poolsOnly and self.ItemClasses[choice] then
		return table.KeyFromValue(self.Loot.Pools, pool)
	end

	while choice and not self.ItemClasses[choice] do
		local new = self.Loot.Pools[choice]

		if not new then
			choice = nil

			return
		end

		choice = table.WeightedRandom(new)

		if poolsOnly and self.ItemClasses[choice] then
			return table.KeyFromValue(self.Loot.Pools, new)
		end
	end

	return choice
end

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
		local cooldown = math.RemapC(playercount, rates[1], max, rates[2], rates[3])

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

		local choice = self:ResolveLoot(v)

		if not choice then
			continue
		end

		ent.StoredItem = choice
	end
end
