util.AddNetworkString("nToggleSpawner")

GM.AreaRatio = 80000
GM.AreaCache = GM.AreaCache or {}
GM.AreaNPCList = GM.AreaNPCList or {}

hook.Add("Think", "ZombieSpawner", function()
	GAMEMODE:SpawnThink()
end)

function GM:GetZombieAmount(area)
	return math.ceil((area:GetSizeX() * area:GetSizeY()) / self.AreaRatio)
end

function GM:PlayerAreaCheck(area, pos)
	for _, v in pairs(player.GetAll()) do
		if v:GetMoveType() == MOVETYPE_NOCLIP then
			continue
		end

		if not v:TestPVS(pos) then
			continue
		end

		if area:IsVisible(v:EyePos()) then
			return false
		end
	end

	return true
end

function GM:SpawnThink()
	for k, v in pairs(self:Spawners()) do
		local area = self.AreaCache[k]
		local max = self:GetZombieAmount(area)
		local count = 0

		self.AreaNPCList[k] = self.AreaNPCList[k] or {}

		local tab = self.AreaNPCList[k]

		for index, npc in pairs(tab) do
			if not IsValid(npc) then
				tab[index] = nil

				continue
			end

			count = count + 1
		end

		if count < max then
			local pos = area:GetRandomPoint()

			local tr = util.TraceHull({
				start = pos,
				endpos = pos,
				mins = Vector(-16, -16, 0),
				maxs = Vector(16, 16, 72)
			})

			if not tr.Hit and self:PlayerAreaCheck(area, pos) then
				local ent = ents.Create("inf_zombie_slow")

				ent:SetPos(pos)
				ent:SetAngles(Angle())

				ent:Spawn()
				ent:Activate()

				table.insert(tab, ent)

				break -- Only one NPC spawn per think
			end
		end
	end
end

function GM:ToggleSpawner(id)
	local tab = self:Spawners()
	local area = navmesh.GetNavAreaByID(id)

	if tab[id] then
		tab[id] = nil
		self.AreaCache[id] = nil

		for _, v in pairs(self.AreaNPCList[id]) do
			if IsValid(v) then
				v:Remove()
			end
		end
	else
		tab[id] = {area:GetCorner(0), area:GetCorner(1), area:GetCorner(2), area:GetCorner(3), area:GetCenter(), self:GetZombieAmount(area)}
		self.AreaCache[id] = area
	end

	self:SetSpawners(tab)
end