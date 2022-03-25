GM.DonationTypes = {
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
	clothingpack = {
		Name = "Clothing Pack",
		Type = "Player",
		OnRedeem = function(ply, data)
			ply:GiveItem("outfitter", 1)
		end
	}
}
