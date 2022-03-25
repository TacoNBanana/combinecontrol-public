local PANEL = {}

AccessorFunc(PANEL, "_row", "Row")
AccessorFunc(PANEL, "_entity", "Entity")

function PANEL:Init()
	self.lblTitle:SetFont("CombineControl.Window")
	self.PerformLayout = CCFramePerformLayout

	self:SetTitle("Crafting")
	self:SetSize(800, 500)
	self:Center()

	self.Categories = vgui.Create("DComboBox", self)
	self.Categories:SetFont("CombineControl.LabelSmall")
	self.Categories:SetPos(10, 34)
	self.Categories:SetSize(400, 20)
	self.Categories:SetSortItems(false)
	self.Categories:PerformLayout()

	self.Categories.OnSelect = function(pnl, index, val, data)
		self:PopulateRecipes(data)
	end

	self.Recipes = vgui.Create("DListView", self)
	self.Recipes:SetPos(10, 64)
	self.Recipes:SetSize(400, self:GetTall() - 74)
	self.Recipes:AddColumn("Category")
	self.Recipes:AddColumn("Name")
	self.Recipes:AddColumn("Tool")

	self.Recipes.OnRowSelected = function(pnl, index, row)
		self:SelectRecipe(row)
	end

	self.Ingredients = vgui.Create("DListView", self)
	self.Ingredients:SetPos(420, 64)
	self.Ingredients:SetSize(370, 188)
	self.Ingredients:AddColumn("Ingredients")
	self.Ingredients:AddColumn("Amount"):SetFixedWidth(50)

	self.ItemRefresh = vgui.Create("DButton", self)
	self.ItemRefresh:SetPos(420, 34)
	self.ItemRefresh:SetSize(370, 20)
	self.ItemRefresh:SetText("Refresh")

	self.ItemRefresh.DoClick = function(pnl)
		net.Start("nClearRenderModel")
			net.WriteEntity(self:GetEntity())
		net.SendToServer()
	end

	self.Results = vgui.Create("DListView", self)
	self.Results:SetPos(420, 264)
	self.Results:SetSize(370, 188)
	self.Results:AddColumn("Result")
	self.Results:AddColumn("Amount"):SetFixedWidth(50)

	self.AmountLabel = vgui.Create("DLabel", self)
	self.AmountLabel:SetPos(420, 470)
	self.AmountLabel:SetSize(370, 20)
	self.AmountLabel:SetFont("CombineControl.LabelSmall")
	self.AmountLabel:SetText("Amount")
	self.AmountLabel:PerformLayout()

	self.Amount = vgui.Create("DTextEntry", self)
	self.Amount:SetPos(470, 470)
	self.Amount:SetSize(20, 20)
	self.Amount:SetValue(1)
	self.Amount:SetUpdateOnType(true)
	self.Amount:PerformLayout()

	self.Amount.AllowInput = function(pnl, val)
		if not string.find(val, "%d") then
			return true
		end
	end

	self.Amount.OnValueChange = function(pnl, val)
		self:SelectRecipe(self:GetRow())
	end

	self.Craft = vgui.Create("DButton", self)
	self.Craft:SetPos(500, 470)
	self.Craft:SetSize(290, 20)
	self.Craft:SetText("Craft")
	self.Craft:SetDisabled(true)

	self.Craft.DoClick = function(pnl)
		local row = self:GetRow()
		local amt = tonumber(self.Amount:GetValue()) or 1

		net.Start("nCraft")
			net.WriteEntity(self:GetEntity())
			net.WriteUInt(row.id, 10)
			net.WriteUInt(amt, 10)
		net.SendToServer()

		self:Remove()
	end

	self:PerformLayout()
end

function PANEL:Think()
	UIAutoClose(self)

	if self:IsActive() and not IsValid(self:GetEntity()) then
		self:Remove()
	end
end

function PANEL:PopulateCategories()
	self.Categories:Clear()

	local allcount = 0
	local categories = {}
	local recipes = GAMEMODE:GetVisibleRecipes(self:GetItems(), self:GetEntity())

	for _, v in pairs(recipes) do
		local tab = GAMEMODE.Crafting[v]

		allcount = allcount + 1

		if not categories[tab.Category] then
			categories[tab.Category] = 1
		else
			categories[tab.Category] = categories[tab.Category] + 1
		end
	end

	local name = string.format("All (%s)", allcount)

	self.Categories:AddChoice(name, nil)
	self.Categories:SetValue(name)

	for cat, count in pairs(categories) do
		local catname = string.format("%s (%s)", cat, count)

		self.Categories:AddChoice(catname, cat)
	end
end

function PANEL:PopulateRecipes(filter)
	self.Recipes:Clear()
	self:SelectRecipe()

	local recipes = GAMEMODE:GetVisibleRecipes(self:GetItems(), self:GetEntity())

	for _, v in pairs(recipes) do
		local tab = GAMEMODE.Crafting[v]

		if filter and filter != tab.Category then
			continue
		end

		local tool = "None"

		if #tab.Tool > 0 then
			tool = GAMEMODE:GetDefaultItemKey(tab.Tool, "Name")
		end

		local item, amt = GAMEMODE:UnpackRecipe(tab.Result[1])
		local name = GAMEMODE:GetDefaultItemKey(item, "Name")

		if amt > 1 then
			name = string.format("%s (x%s)", name, amt)
		end

		local line = self.Recipes:AddLine(tab.Category, name, tool)

		line.id = v
		line.tab = tab
	end

	self.Recipes:FixColumnsLayout()
	self.Recipes:SortByColumns(1, false, 2, false)
end

function PANEL:GetAmount()
	return tonumber(self.Amount:GetValue()) or 1
end

function PANEL:GetItems()
	local tab = {}

	for _, v in pairs(LocalPlayer().Inventory) do
		if class.IsTypeOf(v, "base_equipment") and v:IsWorn() then
			continue
		end

		if v:IsTempItem() then
			continue
		end

		table.insert(tab, v)
	end

	local ent = self:GetEntity()

	if not IsValid(ent) then
		return tab
	end

	table.Add(tab, ent:GetItems())

	return table.Reverse(tab)
end

function PANEL:SelectRecipe(row)
	self.Ingredients:Clear()
	self.Results:Clear()
	self:SetRow(row)

	if not row then
		self.Craft:SetText("Craft")
		self.Craft:SetDisabled(true)

		return
	end

	net.Start("nSelectRecipe")
		net.WriteEntity(self:GetEntity())
		net.WriteUInt(row.id, 10)
	net.SendToServer()

	local amt = self:GetAmount()

	for _, v in pairs(row.tab.Ingredients) do
		local item, amount = GAMEMODE:UnpackRecipe(v)
		local name = GAMEMODE:GetDefaultItemKey(item, "Name")

		self.Ingredients:AddLine(name, amount * amt)
	end

	for _, v in pairs(row.tab.Result) do
		local item, amount = GAMEMODE:UnpackRecipe(v)
		local name = GAMEMODE:GetDefaultItemKey(item, "Name")

		self.Results:AddLine(name, amount * amt)
	end

	local craftable, err = GAMEMODE:CanCraftRecipe(self:GetItems(), self:GetEntity(), row.id, amt)

	if not craftable then
		self.Craft:SetText(err)
		self.Craft:SetDisabled(true)
	else
		self.Craft:SetText("Craft")
		self.Craft:SetDisabled(false)
	end
end

derma.DefineControl("CCCrafting", "", PANEL, "DFrame")
