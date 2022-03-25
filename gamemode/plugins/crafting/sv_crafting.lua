net.Receive("nCraft", function(len, ply)
	local ent = net.ReadEntity()
	local index = net.ReadUInt(10)
	local amt = net.ReadUInt(10)

	if not IsValid(ent) then
		return
	end

	local items = ent:GetItems()

	GAMEMODE:Craft(items, ent, index, amt)
end)

function GM:Craft(items, ent, index, amt)
	local pos = ent:LocalToWorld(ent:OBBCenter() + Vector(0, 0, 30))
	local tab = GAMEMODE.Crafting[index]

	if amt < 1 then return end
	if not tab then return end
	if not GAMEMODE:CanCraftRecipe(items, ent, index, amt) then return end

	for i = 1, amt do
		local ingredients, result = false, false

		if tab.OnCraft != stub then
			ingredients, result = tab:OnCraft(items, ent)
		end

		if not ingredients then
			for _, v in pairs(tab.Ingredients) do
				local item, amount = GAMEMODE:UnpackRecipe(v)

				for i, k in pairs(items) do
					if k:GetClass() == item then
						if class.IsTypeOf(k, "base_stacking") then
							local available = k:GetAmount()

							if amount > available then
								k:TakeAmount(available)

								items[i] = nil

								amount = amount - available
							else
								k:TakeAmount(amount)

								break
							end
						else
							GAMEMODE:DeleteItem(k)

							items[i] = nil

							amount = amount - 1

							if amount < 1 then
								break
							end
						end
					end
				end
			end
		end

		if not result then
			local itemclass = GAMEMODE:UnpackRecipe(tab.Result)

			timer.Simple(3 * i, function()
				if IsValid(ent) then
					pos = ent:LocalToWorld(ent:OBBCenter() + Vector(0, 0, 10))

					if i == amt then
						ent:SetRenderModel("")
					else
						ent:EmitSounds()
					end
				end

				GAMEMODE:DBCreateItem(itemclass, ITEM_WORLD, pos)
			end)
		end
	end

	ent:SetCraftStart(CurTime())
	ent:SetCraftEnd(CurTime() + (3 * amt))
	ent:SetCraftTime(3)
	ent:EmitSounds()
end

net.Receive("nClearRenderModel", function(len, ply)
	local ent = net.ReadEntity()

	if not IsValid(ent) then return end

	ent:SetRenderModel("")
end)

net.Receive("nSelectRecipe", function(len, ply)
	local ent = net.ReadEntity()
	local index = net.ReadUInt(10)
	local tab = GAMEMODE.Crafting[index]

	if not IsValid(ent) then return end
	if not tab then return end
	if not GAMEMODE:CanSeeRecipe(ent:GetItems(), ent, index) then return end

	ent:SetRenderModel(GAMEMODE:GetDefaultItemKey(tab.Result, "Model"))
end)

util.AddNetworkString("nCraft")
util.AddNetworkString("nClearRenderModel")
util.AddNetworkString("nSelectRecipe")
util.AddNetworkString("nCraftingMenu")