function SWEP:DrawHUD()
	if CCP.IronDev then
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawLine(0, ScrH() / 2, ScrW(), ScrH() / 2)
		surface.DrawLine(ScrW() / 2, 0, ScrW() / 2, ScrH())
	end
end