local PANEL = {}

DEFINE_BASECLASS("DProperty_Generic")

function PANEL:Init()
	self.ColorValue = Color(255, 255, 255)

	self.Text = self:Add("DTextEntry")
	self.Text:SetUpdateOnType(true)
	self.Text:SetPaintBackground(false)
	self.Text:Dock(FILL)

	self.Text.OnValueChange = function(pnl, val)
		local tab = string.Explode(" ", val)

		for i = 1, 3 do
			tab[i] = tonumber(tab[i]) or 255
		end

		self:ValueChanged(Color(tab[1], tab[2], tab[3]))
	end

	self.Btn = self:Add("DButton")
	self.Btn:Dock(LEFT)
	self.Btn:DockMargin(0, 2, 4, 2)
	self.Btn:SetWide(16)
	self.Btn:SetText("")

	self.Btn.Paint = function(pnl, w, h)
		surface.SetDrawColor(self.ColorValue.r, self.ColorValue.g, self.ColorValue.b, 255)
		surface.DrawRect(2, 2, w - 4, h - 4)

		surface.SetDrawColor(0, 0, 0, 150)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	self.Btn.DoClick = function()
		self.ColorCombo = vgui.Create("DColorCombo", self)

		self.ColorCombo:SetupCloseButton(function()
			CloseDermaMenus()
		end)

		self.ColorCombo.OnValueChanged = function(pnl, val)
			self.Text:SetValue(string.format("%s %s %s", val.r, val.g, val.b))
			self:ValueChanged(Color(val.r, val.g, val.b))
		end

		self.ColorCombo:SetColor(self.ColorValue)

		local popup = DermaMenu()
		popup:AddPanel(self.ColorCombo)
		popup:SetPaintBackground(false)
		popup:Open(gui.MouseX() + 8, gui.MouseY() + 10)
	end
end

function PANEL:Think()
	BaseClass.Think(self)

	-- local row = self:GetRow()

	-- if not self.SetupRow and IsValid(row) then
	-- 	row.PerformLayout = function(pnl)
	-- 		pnl:SetTall(60)
	-- 		pnl.Label:SetWide(pnl:GetWide() * 0.45)
	-- 	end

	-- 	self.SetupRow = true
	-- end
end

function PANEL:ValueChanged(val, force)
	BaseClass.ValueChanged(self, val, force)

	self.ColorValue = val
end

function PANEL:Setup(vars)
	vars = vars or {}

	self.ColorValue = vars.color or self.ColorValue

	self.Text:SetValue(string.format("%s %s %s", self.ColorValue.r, self.ColorValue.g, self.ColorValue.b))
end

function PANEL:SetValue(val)
	self:Setup({color = val})
end

function PANEL:IsEditing()
	return self.Text:IsEditing() or IsValid(self.ColorCombo)
end

derma.DefineControl("DProperty_Color", "", PANEL, "DProperty_Generic")