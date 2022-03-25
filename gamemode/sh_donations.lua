GM.DonationTypes = {
	maxstats = {
		Name = "Max Stats",
		Type = "Character",
		OnRedeem = function(ply, data)
			for _, v in pairs(GAMEMODE.Stats) do
				ply["Set" .. v](ply, GAMEMODE.MaxAllocatedStats)
				ply:UpdateCharacterField("Stat" .. v, GAMEMODE.MaxAllocatedStats)
			end
		end,
	},
	scoreboardtitle = {
		Name = "Scoreboard Title",
		Type = "Player",
		OnRedeem = function(ply, data)
			local vec = Vector(data.Color.r, data.Color.g, data.Color.b)
			local max = 90
			local text = #data.Title > max and string.sub(data.Title, 1, max) or data.Title

			ply:SetScoreboardTitle(text)
			ply:SetScoreboardTitleC(vec)

			ply:UpdatePlayerField("ScoreboardTitle", text)
			ply:UpdatePlayerField("ScoreboardTitleC", vec)
		end,
		UsePrompt = true,
		Properties = {
			Title = {Type = "Generic", Default = function(ply) return ply:ScoreboardTitle() end},
			Color = {Type = "Color", Default = function(ply) local vec = ply:ScoreboardTitleC() return Color(vec.x, vec.y, vec.z) end}
		}
	},
	custom = {
		Name = "Custom Donation",
		Type = "Player",
		NoRedeem = true,
		OnRedeem = function(ply, data)
			ply:SendChat(nil, "WARNING", "Nothing happens!")
		end
	},
	devdonate = {
		Name = "Developer Donation",
		Type = "Player",
		NoRedeem = true,
		OnRedeem = function(ply, data)
			local val = not ply:PhysgunMode()

			ply:SetPhysgunMode(val)
			ply:UpdatePlayerField("PhysgunMode", val and 1 or 0)

			ply:SetPhysgunColor()
		end
	},
	invupgrade = {
		Name = "Inventory Size Upgrade",
		Type = "Player",
		OnRedeem = function(ply, data)
			ply:SetInvSpaceBonus(ply:InvSpaceBonus() + 30)
			ply:UpdatePlayerField("InvSpaceBonus", ply:InvSpaceBonus())
		end
	}
}