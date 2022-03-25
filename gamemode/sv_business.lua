net.Receive("nBuyBusinessLicense", function(len, ply)
	local id = net.ReadInt(32)
	local license = GAMEMODE.BusinessLicenses[id]

	if not license or not license[2] or bit.band(ply:BusinessLicenses(), id) == id then
		return
	end

	local cost, money = license[2], ply:Money()

	if cost > money then
		return
	else
		ply:SetMoney(money - cost)
		ply:UpdateCharacterField("Money", tostring(ply:Money()))
	end

	ply:SetBusinessLicenses(bit.bor(ply:BusinessLicenses(), id))
	ply:UpdateCharacterField("BusinessLicenses", tostring(ply:BusinessLicenses()))

	net.Start("nPopulateBusiness")
	net.Send(ply)
end)

net.Receive("nBuyItem", function(len, ply)
	local classname = net.ReadString()
	local amt = net.ReadInt(8)

	assertf(GAMEMODE.ItemClasses[classname], "%s tried to buy unknown item '%s'", tostring(ply), classname)

	local item = baseclass.Get(classname)

	if not GAMEMODE:CanBuyItem(classname, ply, amt) then
		return
	end

	local cost = item.BuyPrice * amt

	ply:SetMoney(ply:Money() - cost)
	ply:UpdateCharacterField("Money", tostring(ply:Money()))

	local char = ply:CharID()

	for i = 1, amt do
		GAMEMODE:DBCreateItem(classname, ITEM_PLAYER, char)
	end

	ply:SendChat(nil, "INFO", string.format("You purchased %s item(s) for %s dollars.", amt, cost))
end)
