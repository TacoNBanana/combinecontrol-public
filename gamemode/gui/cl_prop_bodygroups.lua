local PANEL = {}

DEFINE_BASECLASS("DProperty_Generic")

function PANEL:Init()
	self.Bodygroups = {}
	self.Panels = {}
end

function PANEL:Think()
	BaseClass.Think(self)

	local row = self:GetRow()

	if IsValid(row) then
		row.PerformLayout = function(pnl)
			pnl:SetTall(table.Count(self.Panels) * 20)
			pnl.Label:SetWide(pnl:GetWide() * 0.45)
		end
	end
end

function PANEL:Setup(vars)
	for _, v in pairs(self.Panels) do
		v:Remove()
	end

	self.Bodygroups = {}
	self.Panels = {}

	vars = vars or {}

	if not vars.ent then
		return
	end

	for i = 1, vars.ent:GetNumBodyGroups() do
		local k = i + 1
		local default = 0
		local max = vars.ent:GetBodygroupCount(i) - 1

		if max <= 0 then
			continue
		end

		if vars.value then
			default = vars.value[k]
		end

		self.Bodygroups[k] = default

		local slider = self:Add("DNumSlider")

		slider:Dock(TOP)
		slider:SetTall(20)
		slider.Label:SetVisible(false)
		slider.TextArea:Dock(LEFT)
		slider.Slider:DockMargin(0, 3, 8, 3)

		slider:SetDecimals(0)
		slider:SetMax(max)
		slider:SetValue(default)

		slider.OnValueChanged = function(pnl, val)
			self.Bodygroups[k] = math.Round(val)

			self:ValueChanged(self.Bodygroups, true)
		end

		slider.Paint = function()
			slider.Slider:SetVisible(self:IsEditing() or self:GetRow():IsHovered() or self:GetRow():IsChildHovered())
		end

		self.Panels[k] = slider
	end
end

function PANEL:IsEditing()
	for _, v in pairs(self.Panels) do
		if v:IsEditing() then
			return true
		end
	end

	return false
end

derma.DefineControl("DProperty_Bodygroups", "", PANEL, "DProperty_Generic")