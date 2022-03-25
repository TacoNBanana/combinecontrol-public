local meta = FindMetaTable("Player")

function meta:AddDonation(donation)
	local tab = self:Donations()

	table.insert(tab, {
		Timestamp = os.time(),
		Type = donation,
		Redeemed = false
	})

	self:SetDonations(tab)
	self:UpdatePlayerField("Donations", util.TableToJSON(tab))

	GAMEMODE:WriteLog("donation_parsed", {
		Type = donation,
		Ply = GAMEMODE:LogPlayer(self)
	})

	self:SendChat(nil, "WARNING", "Your donation has been processed and is available for redeeming.")
end

net.Receive("nRedeemDonation", function(len, ply)
	local index = net.ReadInt(16)
	local data = net.ReadTable()

	local tab = ply:Donations()

	if not tab[index] or tab[index].Redeemed then
		return
	end

	local donation = GAMEMODE.DonationTypes[tab[index].Type]

	donation.OnRedeem(ply, data)

	if not donation.NoRedeem and not ply:IsDeveloper() then
		tab[index].Redeemed = true

		ply:SetDonations(tab)
		ply:UpdatePlayerField("Donations", util.TableToJSON(tab))

		GAMEMODE:WriteLog("donation_redeemed", {
			Type = tab[index].Type,
			Ply = GAMEMODE:LogPlayer(ply),
			Char = GAMEMODE:LogCharacter(ply)
		})
	end
end)
