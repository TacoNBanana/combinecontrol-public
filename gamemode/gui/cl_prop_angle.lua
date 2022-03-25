local PANEL = {}

DEFINE_BASECLASS("DProperty_Generic")

function PANEL:Init()
	self.Ang = Angle()

	for _, v in pairs({"p", "y", "r"}) do
		local slider = self:Add("DNumSlider")

		slider:Dock(TOP)
		slider:SetTall(20)
		slider.Label:SetVisible(false)
		slider.TextArea:Dock(LEFT)
		slider.Slider:DockMargin(0, 3, 8, 3)

		slider.OnValueChanged = function(pnl, val)
			self.Ang[v] = val

			self:ValueChanged(self.Ang, true)
		end

		slider.Paint = function()
			slider.Slider:SetVisible(self:IsEditing() or self:GetRow():IsHovered() or self:GetRow():IsChildHovered())
		end

		self[v .. "Slider"] = slider
	end
end

function PANEL:Think()
	BaseClass.Think(self)

	local row = self:GetRow()

	if not self.SetupRow and IsValid(row) then
		row.PerformLayout = function(pnl)
			pnl:SetTall(60)
			pnl.Label:SetWide(pnl:GetWide() * 0.45)
		end

		self.SetupRow = true
	end
end

function PANEL:Setup(vars)
	vars = vars or {}

	for _, v in pairs({"p", "y", "r"}) do
		local slider = self[v .. "Slider"]

		slider:SetMin(vars.min or 0)
		slider:SetMax(vars.max or 1)

		if vars.value then
			slider:SetValue(vars.value[v])
		else
			slider:SetValue(0)
		end
	end
end

function PANEL:IsEditing()
	return self.pSlider:IsEditing() or self.ySlider:IsEditing() or self.rSlider:IsEditing()
end

derma.DefineControl("DProperty_Angle", "", PANEL, "DProperty_Generic")