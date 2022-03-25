ENT.Type = "point"
ENT.Base = "base_point"

function ENT:Think()
	for _, v in pairs(player.GetAll()) do
		if v:GetCharFlagAttribute("IgnoreTravelRestriction") then continue end
		if v:IsTravelBanned() then continue end

		local d = v:GetPos():Distance(self:GetPos())

		if d < self.Radius then
			if not v.LastServerOffer then v.LastServerOffer = CurTime() end

			if CurTime() >= v.LastServerOffer + 1 then
				net.Start("nServerOffer")
					net.WriteFloat(self.Location)
					net.WriteFloat(self.Port or 1)
				net.Send(v)
			end
		end
	end
end