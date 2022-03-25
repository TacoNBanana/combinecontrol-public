function ITEM:GetInventoryOptions(ply)
	if not self:CanInteract(ply) then
		return {}
	end

	local tab = {}

	if not self:GetProperty("Generic") then
		table.insert(tab, {
			Name = "View description",
			Func = function(item, user)
				if CLIENT then
					item:CreateUserDescription(true)
				end
			end
		})
	end

	if self.UseCondition and self:GetCondition() > CONDITION_GOOD then
		table.insert(tab, {
			Name = "Repair",
			Func = function(item, user)
				if SERVER then
					if item.ScrapItem then
						local kit = user:GetFirstItem(item.ScrapItem)

						if kit then
							GAMEMODE:DeleteItem(kit)
							item:SetProperty("Condition", CONDITION_GOOD)
						else
							user:SendChat(nil, "ERROR", string.format("You need %s to repair this!", GAMEMODE:GetDefaultItemKey(item.ScrapItem, "Name")))
						end
					else
						local kit = user:GetFirstItem("repairkit")

						if kit then
							GAMEMODE:DeleteItem(kit)
							item:SetProperty("Condition", CONDITION_GOOD)
						else
							user:SendChat(nil, "ERROR", "You need a repair kit!")
						end
					end
				end
			end
		})
	end

	if self:CanSell(ply) then
		table.insert(tab, {
			Name = string.format("Sell (%s)", util.FormatCurrency(self:GetSellPrice())),
			Func = function(item, user)
				if CLIENT then
					net.Start("nSellItem")
						net.WriteInt(item.ID, 32)
						net.WriteUInt(1, 16)
					net.SendToServer()
				end
			end
		})

		if self:GetAmount() > 1 then
			table.insert(tab, {
				Name = "Sell amount",
				Func = function(item, user)
					if CLIENT then
						local ui = vgui.Create("DFrame")

						ui:SetSize(218, 94)
						ui:Center()
						ui:SetTitle("Item Selling")
						ui.lblTitle:SetFont("CombineControl.Window")
						ui:MakePopup()
						ui.PerformLayout = CCFramePerformLayout
						ui:PerformLayout()
						ui.Think = UIAutoClose

						ui.Price = vgui.Create("DLabel", ui)
						ui.Price:SetText(util.FormatCurrency(item:GetSellPrice(1)))
						ui.Price:SetPos(10, 34)
						ui.Price:SetSize(92, 24)
						ui.Price:SetFont("CombineControl.LabelTiny")
						ui.Price:SetContentAlignment(7)
						ui.Price:PerformLayout()

						ui.Amount = vgui.Create("DTextEntry", ui)
						ui.Amount:SetPos(10, 54)
						ui.Amount:SetSize(60, 30)
						ui.Amount:SetFont("CombineControl.LabelSmall")
						ui.Amount:PerformLayout()
						ui.Amount:SetValue(1)
						ui.Amount:SetCaretPos(1)
						ui.Amount:RequestFocus()

						function ui.Amount:OnValueChange(val)
							local amt = tonumber(val)

							if not amt then
								return
							end

							ui.Sell:Calculate(amt)
						end

						function ui.Amount:AllowInput(val)
							if not string.find(val, "%d") then
								return true
							end
						end

						ui.Sell = vgui.Create("DButton", ui)
						ui.Sell:SetFont("CombineControl.LabelSmall")
						ui.Sell:SetText("Sell")
						ui.Sell:SetPos(78, 54)
						ui.Sell:SetSize(60, 30)

						function ui.Sell:Calculate(val)
							val = math.Round(val)

							if not item:CanSell(ply, val) then
								self:SetDisabled(true)
							else
								self:SetDisabled(false)
							end

							ui.Price:SetText(util.FormatCurrency(item:GetSellPrice(val)))
						end

						function ui.Sell:Think()
							local val = tonumber(ui.Amount:GetValue())

							if not val then
								return
							end

							self:Calculate(val)
						end

						function ui.Sell:DoClick()
							local val = tonumber(ui.Amount:GetValue())

							if not val then
								return
							end

							net.Start("nSellItem")
								net.WriteInt(item.ID, 32)
								net.WriteUInt(val, 16)
							net.SendToServer()

							ui:Close()
						end

						ui.Sell:Calculate(1)
						ui.Sell:PerformLayout()

						ui.SellAll = vgui.Create("DButton", ui)
						ui.SellAll:SetFont("CombineControl.LabelSmall")
						ui.SellAll:SetText("Sell all")
						ui.SellAll:SetPos(146, 54)
						ui.SellAll:SetSize(60, 30)

						function ui.SellAll:DoClick()
							net.Start("nSellItem")
								net.WriteInt(item.ID, 32)
								net.WriteUInt(item:GetAmount(), 16)
							net.SendToServer()

							ui:Close()
						end

						ui.SellAll:PerformLayout()

					end
				end
			})
		end
	end

	return tab
end

function ITEM:GetName()
	local name = self:GetProperty("Name")
	local cond = self:GetCondition()

	if cond == CONDITION_DAMAGED then
		name = "Damaged " .. name
	elseif cond == CONDITION_HEAVILYDAMAGED then
		name = "Heavily Damaged " .. name
	elseif cond == CONDITION_BROKEN then
		name = "Broken " .. name
	end

	return name
end

function ITEM:GetWeight()
	return self:GetProperty("Weight")
end

function ITEM:GetCarryAdd()
	return self:GetProperty("CarryAdd")
end

function ITEM:GetAmount()
	return 1
end

function ITEM:GetCondition()
	return self:GetProperty("Condition")
end

function ITEM:GetSellPrice(amt)
	local cond = self:GetCondition()
	local price = self:GetProperty("SellPrice") * self:GetProperty("SellConditionMult")[cond]

	amt = amt or 1

	return math.floor(price * amt)
end