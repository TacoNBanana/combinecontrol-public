net.Receive("nBuyBusinessLicense", function(len, ply)
	-- local id = net.ReadInt(32)
	-- local license = GAMEMODE.BusinessLicenses[id]

	-- if not license or not license[2] or bit.band(ply:BusinessLicenses(), id) == id then
	-- 	return
	-- end

	-- local cost, money = license[2], ply:Money()

	-- if cost > money then
	-- 	return
	-- else
	-- 	ply:SetMoney(money - cost)
	-- 	ply:UpdateCharacterField("Money", tostring(ply:Money()))
	-- end

	-- ply:SetBusinessLicenses(id)
	-- ply:UpdateCharacterField("BusinessLicenses", tostring(ply:BusinessLicenses()))

	-- GAMEMODE:WriteLog("character_buy_license", {Char = GAMEMODE:LogCharacter(ply), License = license[1]})

	-- net.Start("nPopulateBusiness")
	-- net.Send(ply)
end)

net.Receive("nBuyItem", function(len, ply)
	-- local classname = net.ReadString()
	-- local amt = net.ReadInt(16)

	-- assertf(GAMEMODE.ItemClasses[classname], "%s tried to buy unknown item '%s'", tostring(ply), classname)

	-- local item = baseclass.Get(classname)

	-- if not GAMEMODE:CanBuyItem(classname, ply, amt) then
	-- 	return
	-- end

	-- local cost = item.BuyPrice * amt

	-- ply:SetMoney(ply:Money() - cost)
	-- ply:UpdateCharacterField("Money", tostring(ply:Money()))

	-- ply:GiveItem(classname, amt, function(ent)
	-- 	GAMEMODE:WriteLog("item_business_buy", {Char = GAMEMODE:LogCharacter(ply), Item = GAMEMODE:LogItem(ent), Amount = amt, Price = cost})
	-- end)

	-- ply:SendChat(nil, "INFO", string.format("Purchased %s (x%s) for %s.", item.Name, amt, util.FormatCurrency(cost)))
end)

net.Receive("nSellItem", function(len, ply)
	-- local id = net.ReadInt(32)
	-- local amt = net.ReadUInt(16)
	-- local item = GAMEMODE:GetItem(id)

	-- if not item or not item:CanSell(ply, amt) then
	-- 	return
	-- end

	-- local price = item:GetSellPrice(amt)

	-- if class.IsTypeOf(item, "base_stacking") then
	-- 	item:TakeAmount(amt)
	-- else
	-- 	GAMEMODE:DeleteItem(item)
	-- end

	-- ply:SetMoney(ply:Money() + price)
	-- ply:UpdateCharacterField("Money", tostring(ply:Money()))

	-- ply:SendChat(nil, "INFO", string.format("Sold %s (x%s) for %s.", item.Name, amt, util.FormatCurrency(price)))
	-- GAMEMODE:WriteLog("item_business_sell", {Char = GAMEMODE:LogCharacter(ply), Item = GAMEMODE:LogItem(item), Amount = amt, Price = price})
end)
