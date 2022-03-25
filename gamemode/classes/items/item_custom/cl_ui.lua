local function NewRow(property, category, parent, value)
	local r = parent:CreateRow(category, property)

	parent.Data[property] = value

	r.Paint = function(pnl, w, h)
		if not IsValid(pnl.Inner) then
			return
		end

		local skindata = pnl:GetSkin()
		local alt = parent.Data[property] != value

		if alt then
			surface.SetDrawColor(Color(200, 100, 100))
			surface.DrawRect(0, 0, w * 0.45, h)
		end

		surface.SetDrawColor(skindata.Colours.Properties.Border)
		surface.DrawRect(w - 1, 0, 1, h)
		surface.DrawRect(w * 0.45, 0, 1, h)
		surface.DrawRect(0, h-1, w, 1)

		r.Label:SetTextColor(skindata.Colours.Properties.Label_Selected)
	end

	r:GetParent().Paint = function(pnl, w, h)
		surface.SetDrawColor(Color(57, 57, 57))
		surface.DrawRect(0, 0, w, h)
	end

	return r
end

local propertyRows = {}

propertyRows["Name"] = {Category = "Item", Func = function(property, item, ui, parent, category)
	local value = item:GetProperty(property)
	local r = NewRow(property, category, parent, value)

	r:Setup("Generic")
	r:SetValue(value)

	r.DataChanged = function(self, val)
		ui[property]:SetText(val)

		parent.Data[property] = val
	end
end}

propertyRows["Description"] = propertyRows["Name"]

propertyRows["Model"] = {Category = "Item", Func = function(property, item, ui, parent, category)
	local value = item:GetProperty(property)
	local r = NewRow(property, category, parent, value)

	r:Setup("Generic")
	r:SetValue(value)

	r.DataChanged = function(self, val)
		parent.Data[property] = val
	end
end}

propertyRows["Materials"] = {Category = "Model", Func = function(property, item, ui, parent, category)
	local value = item:GetProperty(property)
	local r = NewRow(property, category, parent, value)

	r:Setup("Generic")
	r:SetValue(value)

	r.DataChanged = function(self, val)
		local ent = CCP.CustomItemUI.ModelPreview:GetEntity()
		if IsValid(ent) then
			ent:SetMaterial(val)
		end

		parent.Data[property] = val
	end
end}

propertyRows["Skin"] = {Category = "Model", Func = function(property, item, ui, parent, category)
	local ent = ui.ModelPreview:GetEntity()

	if IsValid(ent) then
		local count = ent:SkinCount()

		if count <= 1 then
			return
		end

		local value = item:GetProperty(property)
		local r = NewRow(property, category, parent, value)

		r:Setup("Int", {min = 1, max = count})
		r:SetValue(value)

		r.DataChanged = function(self, val)
			val = math.Round(val - 1)

			ent:SetSkin(val)

			parent.Data[property] = val
		end
	end
end}

propertyRows["Scale"] = {Category = "Model", Func = function(property, item, ui, parent, category)
	local value = item:GetProperty(property)
	local r = NewRow(property, category, parent, value)

	r:Setup("Float", {min = 0.1, max = 10})
	r:SetValue(item:GetProperty(property))

	r.DataChanged = function(self, val)
		parent.Data[property] = math.Round(val, 2)
	end
end}

propertyRows["IconFOV"] = {Category = "Icon", Func = function(property, item, ui, parent, category)
	local value = item:GetProperty(property)
	local r = NewRow(property, category, parent, value)

	r:Setup("Float", {min = -1, max = 50})
	r:SetValue(item:GetProperty(property))

	r.DataChanged = function(self, val)
		val = math.Round(val, 2)
		local preview = CCP.CustomItemUI.ModelPreview
		local fov
		if val <= 0 then
			local ent = preview:GetEntity()
			fov = PositionSpawnIcon(ent, ent:GetPos()).fov
		end

		if preview then
			preview:SetFOV(val > 0 and val or fov)
		end

		parent.Data[property] = val
	end
end}

propertyRows["Weight"] = {Category = "Item", Func = function(property, item, ui, parent, category)
	local value = item:GetProperty(property)
	local r = NewRow(property, category, parent, value)

	r:Setup("Float", {min = 0, max = 50})
	r:SetValue(item:GetProperty(property))

	r.DataChanged = function(self, val)
		val = math.Round(val, 2)
		ui[property]:SetText(string.format("%s: %.2f", property, val))
		ui[property]:SizeToContents()

		parent.Data[property] = val
	end
end}

propertyRows["CarryAdd"] = propertyRows["Weight"]

propertyRows["Bodygroups"] = {Category = "Model", Func = function(property, item, ui, parent, category)
	local ent = CCP.CustomItemUI.ModelPreview:GetEntity()

	if ent:GetNumBodyGroups() <= 1 then
		return
	end

	local value = item:GetProperty(property)
	local r = NewRow(property, category, parent, value)

	r:Setup("Bodygroups", {ent = ent, value = value})

	r.DataChanged = function(self, val)
		parent.Data[property] = val

		for k, v in pairs(val) do
			if not isnumber(k) then
				continue
			end

			ent:SetBodygroup(k - 1, v)
		end
	end
end}

propertyRows["Color"] = {Category = "Model", Func = function(property, item, ui, parent, category)
	local col = item:GetProperty(property)
	local r = NewRow(property, category, parent, Color(col.r, col.g, col.b))

	r:Setup("Color", {color = Color(col.r, col.g, col.b)})

	r.DataChanged = function(self, val)
		local preview = CCP.CustomItemUI.ModelPreview
		if preview then
			preview:SetColor(val)
		end

		parent.Data[property] = val
	end
end}

propertyRows["CamOffset"] = {Category = "Icon", Func = function(property, item, ui, parent, category)
	local value = item:GetProperty(property)
	local r = NewRow(property, category, parent, value)

	r:Setup("Vector", {min = -100, max = 100, value = item:GetProperty(property)})

	r.DataChanged = function(self, val)
		local preview = CCP.CustomItemUI.ModelPreview
		local ent = preview:GetEntity()
		local origin = PositionSpawnIcon(ent, ent:GetPos()).origin
		if preview and origin then
			preview:SetCamPos(origin + val)
			ent:SetAngles(parent.Data["AngOffset"])
		end

		parent.Data[property] = val
	end
end}

propertyRows["AngOffset"] = {Category = "Icon", Func = function(property, item, ui, parent, category)
	local value = item:GetProperty(property)
	local r = NewRow(property, category, parent, value)

	r:Setup("Angle", {min = -180, max = 180, value = item:GetProperty(property)})

	r.DataChanged = function(self, val)
		local ent = CCP.CustomItemUI.ModelPreview:GetEntity()
		if ent then
			ent:SetAngles(val)
		end

		parent.Data[property] = val
	end
end}

function ITEM:RefreshEditUI()
	local ui = CCP.CustomItemUI

	if not ui then
		return
	end

	self:ConfigureModelPanel(ui.ModelPreview)

	ui.Name:SetText(self:GetProperty("Name"))
	ui.Description:SetText(self:GetProperty("Description"))

	ui.Weight:SetText("Weight: " .. self:GetWeight())
	ui.Weight:SizeToContents()
	ui.CarryAdd:SetText("CarryAdd: " .. self:GetCarryAdd())
	ui.CarryAdd:SizeToContents()

	ui.Properties.Data = {}
	ui.Properties:Clear()

	for _, property in ipairs(self.EditableProperties) do
		local tab = propertyRows[property]

		if tab and isfunction(tab.Func) then
			tab.Func(property, self, ui, ui.Properties, tab.Category)
		end
	end
end

net.Receive("nRefreshEditUI", function(len)
	local id = net.ReadInt(32)
	local item = GAMEMODE.Items[id]

	if item then
		item:RefreshEditUI()
	end
end)

function ITEM:OpenEditUI()
	CCP.CustomItemUI = vgui.Create("DFrame")

	local ui = CCP.CustomItemUI

	ui.Item = self

	ui:SetSize(800, 34 + 400)
	ui:SetTitle("Item Customisation")
	ui.lblTitle:SetFont("CombineControl.Window")
	ui.PerformLayout = CCFramePerformLayout
	ui:PerformLayout()

	ui.Think = UIAutoClose

	ui:MakePopup()
	ui:Center()

	local bg = ui:Add("DPanel")
	bg:SetPaintBackground(false)
	bg:Dock(FILL)

	local left = bg:Add("DPanel")
	left:SetPaintBackground(false)
	left:Dock(LEFT)
	left:SetWide(400)

	local icons = left:Add("DPanel")
	icons:SetPaintBackground(false)
	icons:Dock(TOP)
	icons:SetTall(200)

	icons.PaintOver = function(pnl, w, h)
		surface.SetDrawColor(0, 0, 0, 70)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	ui.ModelPreview = icons:Add("DModelPanel")
	ui.ModelPreview:DockMargin(100, 0, 100, 0)
	ui.ModelPreview:Dock(FILL)
	ui.ModelPreview:InvalidateParent(true)
	ui.ModelPreview.LayoutEntity = stub
	ui.ModelPreview:SetModel(self:GetProperty("Model"))

	self:ConfigureModelPanel(ui.ModelPreview)

	local data = left:Add("DPanel")
	data:SetPaintBackground(false)
	data:DockMargin(0, 6, 0, 0)
	data:Dock(FILL)

	ui.Name = data:Add("DLabel")
	ui.Name:DockMargin(3, 0, 0, 0)
	ui.Name:Dock(TOP)
	ui.Name:SetFont("CombineControl.LabelGiant")
	ui.Name:SetText(self:GetProperty("Name"))

	local weights = data:Add("DPanel")
	weights:SetPaintBackground(false)
	weights:DockMargin(0, 6, 0, 0)
	weights:Dock(BOTTOM)

	ui.Weight = weights:Add("DLabel")
	ui.Weight:DockMargin(3, 0, 0, 0)
	ui.Weight:Dock(LEFT)
	ui.Weight:SetFont("CombineControl.LabelSmall")
	ui.Weight:SetText("Weight: " .. self:GetWeight())

	ui.CarryAdd = weights:Add("DLabel")
	ui.CarryAdd:DockMargin(6, 0, 0, 0)
	ui.CarryAdd:Dock(LEFT)
	ui.CarryAdd:SetFont("CombineControl.LabelSmall")
	ui.CarryAdd:SetText("CarryAdd: " .. self:GetCarryAdd())

	ui.Description = data:Add("DLabel")
	ui.Description:DockMargin(3, 3, 0, 3)
	ui.Description:Dock(FILL)
	ui.Description:SetFont("CombineControl.LabelSmall")
	ui.Description:SetText(self:GetProperty("Description"))
	ui.Description:SetWrap(true)

	ui.Properties = bg:Add("DProperties")
	ui.Properties:DockMargin(3, 0, 0, 3)
	ui.Properties:Dock(FILL)

	self:RefreshEditUI()

	local buttons = bg:Add("DPanel")
	buttons:SetPaintBackground(true)
	buttons:DockMargin(3, 0, 0, 0)
	buttons:Dock(BOTTOM)
	buttons:SetTall(22)

	local save = buttons:Add("DButton")
	save:Dock(LEFT)
	save:SetWide(200)
	save:SetText("Save")
	save.DoClick = function()
		net.Start("nSaveCustomItemData")
			net.WriteInt(self.ID, 32)
			net.WriteTable(ui.Properties.Data)
		net.SendToServer()
	end

	local reset = buttons:Add("DButton")
	reset:Dock(LEFT)
	reset:SetWide(200)
	reset:SetText("Reset")
	reset.DoClick = function()
		self:RefreshEditUI()
	end
end

function ITEM:OpenImportUI()
	CCP.CustomImportUI = vgui.Create("DFrame")

	local ui = CCP.CustomImportUI

	ui:SetSize(300, 114)
	ui:Center()
	ui:SetTitle("Import/Export")
	ui.lblTitle:SetFont("CombineControl.Window")
	ui:MakePopup()
	ui.PerformLayout = CCFramePerformLayout
	ui:PerformLayout()

	ui.Think = UIAutoClose

	ui.entry = ui:Add("DTextEntry")
	ui.entry:SetFont("CombineControl.LabelBig")
	ui.entry:SetPos(10, 34)
	ui.entry:SetSize(280, 30)
	ui.entry:PerformLayout()

	local export = {}

	for _, v in pairs(self.EditableProperties) do
		if self.Overrides[v] then
			export[v] = self.Overrides[v]
		end
	end

	ui.entry:SetValue(base64.Encode(pon.encode(export)))

	ui.entry.OnChange = function(pnl)
		local func = function()
			pon.decode(base64.Decode(pnl:GetValue()))
		end

		local ok = pcall(func)

		ui.save:SetDisabled(not ok)
	end

	ui.copy = ui:Add("DButton")
	ui.copy:SetFont("CombineControl.LabelSmall")
	ui.copy:SetText("Copy")
	ui.copy:SetPos(180, 74)
	ui.copy:SetSize(50, 30)
	ui.copy.DoClick = function()
		SetClipboardText(ui.entry:GetValue())
	end

	ui.save = ui:Add("DButton")
	ui.save:SetFont("CombineControl.LabelSmall")
	ui.save:SetText("Save")
	ui.save:SetPos(240, 74)
	ui.save:SetSize(50, 30)
	ui.save.DoClick = function()
		if ui.save:GetDisabled() then
			return
		end

		net.Start("nImportCustomItemData")
			net.WriteInt(self.ID, 32)
			net.WriteString(ui.entry:GetValue())
		net.SendToServer()

		ui:Close()
	end

	ui.entry.OnEnter = ui.save.DoClick
end