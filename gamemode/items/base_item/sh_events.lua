function ITEM:OnPickup(ply, loaded)
end

function ITEM:OnRemove(ply)
end

if SERVER then
	function ITEM:OnCreated()
	end

	function ITEM:OnRepaired(condition)
	end

	function ITEM:OnWorldUse(ply)
		if not self:CanPickup(ply) then
			return
		end

		self:SetItemLocation(ITEM_PLAYER, ply:CharID())

		GAMEMODE:WriteLog("item_pickup", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Item = GAMEMODE:LogItem(self)})
	end

	function ITEM:OnPlayerSpawn(ply)
	end

	function ITEM:OnPlayerDeath(ply)
	end

	function ITEM:OnDrop(ply)
		self:SetItemLocation(ITEM_WORLD, GAMEMODE:GetItemDropLocation(ply))

		GAMEMODE:WriteLog("item_drop", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Item = GAMEMODE:LogItem(self)})
	end

	function ITEM:OnDestroy()
	end

	function ITEM:OnBreak()
	end

	function ITEM:OnCustomSetup()
	end
end
