ITEM = class.Create("base_item")
DEFINE_BASECLASS("base_item")

ITEM.Name 		= "base_stacking"

ITEM.Blacklist 	= table.AddToCopy(BaseClass.Blacklist, {Generic = true, MaxStack = true})

ITEM.Amount 	= 1
ITEM.MaxStack 	= 0

function ITEM:GetName()
	local name = BaseClass.GetName(self)

	return name .. " x" .. self:GetAmount()
end

function ITEM:GetWeight()
	local weight = BaseClass.GetWeight(self)

	if weight == 0 then
		return 0
	end

	weight = weight * self:GetAmount()
	weight = math.max(0.1, weight)

	return math.Round(weight, 1)
end

function ITEM:GetAmount()
	return self:GetProperty("Amount")
end

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	table.insert(tab, {
		Name = "Drop all",
		Func = function(item, user)
			if SERVER then
				item:DropAmount(user, item:GetAmount())
			end
		end
	})

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end

function ITEM:CanPickup(ply, silent)
	if self:IsInPlayerInventory(ply) then
		if not silent then
			ply:SendChat(nil, "ERROR", "You're already carrying this.")
		end

		return false
	end

	local max = self.MaxStack
	local stack = ply:GetFirstItem(self:GetClass())

	if max > 0 and stack and stack:GetAmount() >= max then
		if not silent then
			ply:SendChat(nil, "ERROR", "You can't carry any more of this!")
		end

		return false
	end

	local weight = BaseClass.GetWeight(self) -- Baseclass getweight doesn't take stacking into account

	if weight < 0 then
		return true
	end

	if (ply:InventoryWeight() + weight) > ply:InventoryMaxWeight() then
		if not silent then
			ply:SendChat(nil, "ERROR", "That's too heavy for you to carry.")
		end

		return false
	end

	return true
end

if CLIENT then
	function ITEM:CreateInventoryIcon(admin)
		local icon = BaseClass.CreateInventoryIcon(self, admin)
		local amount = self:GetAmount()

		if amount > 1 then
			local label = vgui.Create("DLabel", icon)
			label:SetPos(0, 0)
			label:SetSize(48, 48)
			label:SetFont("CombineControl.LabelSmall")
			label:SetText(amount)
			label:SetContentAlignment(3)
		end

		return icon
	end
else
	function ITEM:OnWorldUse(ply)
		if not self:CanPickup(ply) then
			return
		end

		local amt = self:GetAmount()
		local weight = BaseClass.GetWeight(self)

		if weight > 0 then
			local space = ply:InventoryMaxWeight() - ply:InventoryWeight()

			amt = math.min(amt, math.floor(space / weight))
		end

		local max = self.MaxStack
		local stack = ply:GetFirstItem(self:GetClass())

		if max > 0 then
			if stack then
				amt = math.min(amt, max - stack:GetAmount())
			else
				amt = math.min(amt, max)
			end
		end

		if self:GetAmount() == amt then
			self:SetItemLocation(ITEM_PLAYER, ply:CharID())
		else
			ply:GiveItem(self:GetClass(), amt)

			self:TakeAmount(amt)
		end

		GAMEMODE:WriteLog("item_pickup", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Item = GAMEMODE:LogItem(self, amt)})
	end

	function ITEM:OnPickup(ply, loaded)
		for _, v in pairs(ply.Inventory) do
			if v:GetClass() == self:GetClass() and v != self then
				local amount = self:GetAmount()

				v:AddAmount(amount)
				self:TakeAmount(amount)

				break
			end
		end
	end

	function ITEM:OnDrop(ply)
		net.Start("nDropAmount")
			net.WriteInt(self.ID, 32)
		net.Send(ply)
	end

	function ITEM:OnCustomSetup(amt)
		amt = tonumber(amt)

		if amt then
			amt = math.max(1, amt)

			self:SetAmount(amt)
		end
	end

	function ITEM:TakeAmount(val)
		local amount = self:GetAmount()

		if val > amount then
			return false
		end

		if amount - val < 1 then
			-- Should save us a lot of DB entries for stacked items
			self:SetAmount(nil)

			GAMEMODE:DeleteItem(self)
		else
			self:SetProperty("Amount", amount - val)
		end

		return true
	end

	function ITEM:AddAmount(val)
		val = self:GetProperty("Amount") + val

		self:SetProperty("Amount", val)
	end

	function ITEM:SetAmount(val)
		self:SetProperty("Amount", val)
	end

	function ITEM:DropAmount(ply, val)
		if val <= 0 then
			return
		end

		local amount = self:GetAmount()

		if val > amount then
			ply:SendChat(nil, "ERROR", "You cannot drop this many items!")

			return
		end

		amount = amount - val

		if amount <= 0 then
			self:SetItemLocation(ITEM_WORLD, GAMEMODE:GetItemDropLocation(ply))
		else
			GAMEMODE:DBCreateItem(self:GetClass(), ITEM_WORLD, GAMEMODE:GetItemDropLocation(ply), function(newitem)
				newitem:SetAmount(val)

				GAMEMODE:WriteLog("item_drop", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Item = GAMEMODE:LogItem(newitem)})
			end)

			self:TakeAmount(val)
		end
	end
end
