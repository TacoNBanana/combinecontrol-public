ENT.Type = "brush"
ENT.Base = "base_brush"

function ENT:Touch(e)
	if e:GetParent() and e:GetParent():IsValid() then return end
	if e:IsPlayer() and e:GetVehicle() and e:GetVehicle():IsValid() then return end

	if self.Landmark and self.Landmark2 then
		local close = ents.FindByName(self.Landmark)[1]
		local far = ents.FindByName(self.Landmark2)[1]

		if close:IsValid(close) and IsValid(far) then
			if self.Fade and self.Fade == "1" then
				if not e.FadeTeleport then
					e.FadeTeleport = true
					e:ScreenFade(SCREENFADE.IN, Color(0, 0, 0, 255), 1, 1)

					timer.Simple(1.95, function()
						if IsValid(e) then
							local dist = close:GetPos() - e:GetPos()

							e:SetPos(far:GetPos() - dist)
							e:ScreenFade(SCREENFADE.OUT, Color(0, 0, 0, 255), 1, 0)
							e.FadeTeleport = false
						end
					end)
				end
			else
				local dist = close:GetPos() - e:GetPos()

				e:SetPos(far:GetPos() - dist)
			end
		end
	end
end

function ENT:KeyValue(key, value)
	if key == "landmark" then
		self.Landmark = value
	end

	if key == "landmark2" then
		self.Landmark2 = value
	end

	if key == "fade" then
		self.Fade = value
	end
end
