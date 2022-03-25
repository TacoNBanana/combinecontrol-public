AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "cc_base_ent"

ENT.Category		= "CombineControl"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

ENT.SearchTime 		= 5

if SERVER then
	function ENT:Initialize()
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetUseType(SIMPLE_USE)

		self:GetPhysicsObject():EnableMotion(false)
	end

	function ENT:Use(ply)
		if self:IsBeingSearched() then
			if self.SearchPlayer != ply then
				ply:SendChat(nil, "WARNING", "Someone else is already searching through here!")
			end

			return
		end

		self.SearchPlayer = ply
		self.SearchPos = ply:GetPos()
		self.SearchFinish = CurTime() + self.SearchTime

		self:EmitSound("items/ammocrate_open.wav")

		net.Start("nCreateTimedProgressBar")
			net.WriteFloat(5)
			net.WriteString("Searching...")
		net.Send(ply)
	end

	function ENT:Think()
		if self.StoredItem and GAMEMODE.LootData.Disabled[self:GetLootPool()] then
			self.StoredItem = nil
		end

		if self.SearchFinish and self.SearchFinish < CurTime() then
			self:FinishSearch()
		end
	end

	function ENT:ClearSearch()
		self.SearchPlayer = nil
		self.SearchPos = nil
		self.SearchFinish = nil
	end

	function ENT:IsBeingSearched()
		if not self.SearchFinish then
			return false
		end

		return IsValid(self.SearchPlayer) and self.SearchPlayer:Alive() and self.SearchPlayer:GetPos() == self.SearchPos
	end

	function ENT:FinishSearch()
		if not self:IsBeingSearched() then
			self:ClearSearch()

			return
		end

		local ply = self.SearchPlayer

		self:ClearSearch()
		self:EmitSound("items/ammocrate_close.wav")

		if not self.StoredItem then
			ply:SendChat(nil, "WARNING", "You fail to find anything useful")

			return
		end

		ply:SendChat(nil, "WARNING", "You found an item! (" .. GAMEMODE:GetDefaultItemKey(self.StoredItem, "Name") .. ")")

		ply:GiveItem(self.StoredItem, 1, function(item)
			local pos = self:GetPos()

			GAMEMODE:WriteLog("item_loot", {
				Char = GAMEMODE:LogCharacter(ply),
				Item = GAMEMODE:LogItem(item),
				X = math.Round(pos.x, 2),
				Y = math.Round(pos.y, 2),
				Z = math.Round(pos.z, 2),
				Pool = self:GetLootPool()
			})
		end)

		self.StoredItem = nil
	end

	function ENT:RegisterWithLootPool(pool)
		self:SetLootPool(pool)

		GAMEMODE.LootData.Entities[pool] = GAMEMODE.LootData.Entities[pool] or {}
		GAMEMODE.LootData.Entities[pool][self] = true
	end

	function ENT:OnRemove()
		GAMEMODE.LootData.Entities[self:GetLootPool()][self] = nil
	end
end

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "LootPool")
end

function ENT:CanPhysgun()
	return false
end

function ENT:CanTool(ply)
	return false
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()

		if GAMEMODE.SeeAll and LocalPlayer():IsAdmin() then
			GAMEMODE:DrawWorldText(self:WorldSpaceCenter() + Vector(0, 0, self:BoundingRadius()), self:GetLootPool())
		end
	end
end