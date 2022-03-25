ITEM = class.Create("base_item")
DEFINE_BASECLASS("base_item")

ITEM.Name 			= "Instant Outfitter"
ITEM.Description 	= "The only developer approved way to give yourself a fresh look!"

ITEM.Model			= Model("models/Gibs/HGIBS.mdl")

ITEM.Weight 		= 0.1

ITEM.Options 		= {
	{
		hat_bandana_green = {[1] = {bodygroups = {hat = 9}}},
		hat_bandana_red = {[1] = {bodygroups = {hat = 8}}},
		hat_baseball = {[1] = {bodygroups = {hat = 3}}},
		hat_baseball_goggles = {[1] = {bodygroups = {hat = 2}}},
		hat_cowboy = {[1] = {bodygroups = {hat = 10}}},
		hat_beanie = {[1] = {bodygroups = {hat = 5}}},
		hat_beanie_alt = {[1] = {bodygroups = {hat = 4}}},
		hat_beret_green = {[1] = {bodygroups = {hat = 6}}},
		hat_beret_red = {[1] = {bodygroups = {hat = 6}, materials = {["models/tnb/techcom/trenchcoat1"] = "models/tnb/techcom/trenchcoat2"}}},
		hat_beret_black = {[1] = {bodygroups = {hat = 6}, materials = {["models/tnb/techcom/trenchcoat1"] = "models/tnb/techcom/trenchcoat3"}}}
	}, {
		eyes_aviators = {[1] = {bodygroups = {eyewear = 3}}},
		eyes_glasses = {[1] = {bodygroups = {eyewear = 5}}},
		eyes_glasses_half = {[1] = {bodygroups = {eyewear = 8}}},
		eyes_glasses_thick = {[1] = {bodygroups = {eyewear = 4}}},
		eyes_shades = {[1] = {bodygroups = {eyewear = 1}}}
	}, {
		mask_cigar = {[1] = {bodygroups = {mask = 3}}},
		mask_cigarette = {[1] = {bodygroups = {mask = 8}}},
		mask_facewrap = {[1] = {bodygroups = {mask = 1}, materials = {["models/tnb/citizens/facewrap3"] = "models/tnb/techcom/bandana_1"}}},
		mask_facewrap_blue = {[1] = {bodygroups = {mask = 1}}},
		mask_facewrap_red = {[1] = {bodygroups = {mask = 1}, materials = {["models/tnb/citizens/facewrap3"] = "models/tnb/techcom/facewrap1"}}},
		mask_shemagh = {
			[1] = {bodygroups = {mask = 2}},
			[2] = {bodygroups = {shemagh = 1}, materials = {["models/ninja/cod4r/chr/marines/marine_keffiyeh_col"] = "models/tnb/techcom/shemagh1"}}
		}
	}, {
		clothing_casual = {[2] = {model = "models/tnb/clothing/trp/body/%s_casual.mdl"}},
		clothing_clearsky_grey = {[2] = {model = "models/tnb/clothing/trp/body/%s_clearsky.mdl", skin = 2}},
		clothing_clearsky_navy = {[2] = {model = "models/tnb/clothing/trp/body/%s_clearsky.mdl"}},
		clothing_clearsky_woodland = {[2] = {model = "models/tnb/clothing/trp/body/%s_clearsky.mdl", skin = 1}},
		clothing_dirty = {[2] = {model = "models/tnb/clothing/trp/body/%s_dirtyvest.mdl"}},
		clothing_drifter_black = {[2] = {model = "models/tnb/clothing/trp/body/%s_drifter.mdl", skin = 1}},
		clothing_drifter_brown = {[2] = {model = "models/tnb/clothing/trp/body/%s_drifter.mdl"}},
		clothing_jacket = {[2] = {model = "models/tnb/clothing/trp/body/%s_survivor_jacket.mdl", skin = 1}},
		clothing_killer = {[2] = {model = "models/tnb/clothing/trp/body/%s_killer.mdl"}},
		clothing_leatherjacket_black = {[2] = {model = "models/tnb/clothing/trp/body/%s_survivor_leatherjacket.mdl", skin = 1}},
		clothing_leatherjacket_brown = {[2] = {model = "models/tnb/clothing/trp/body/%s_survivor_leatherjacket.mdl"}},
		clothing_parka_blue = {[2] = {model = "models/tnb/clothing/trp/body/%s_rebel.mdl"}},
		clothing_parka_charcoal = {[2] = {model = "models/tnb/clothing/trp/body/%s_rebel2.mdl"}},
		clothing_parka_coyote = {[2] = {model = "models/tnb/clothing/trp/body/%s_rebel2.mdl", skin = 1}},
		clothing_parka_olive = {[2] = {model = "models/tnb/clothing/trp/body/%s_rebel2.mdl", skin = 2}},
		clothing_parka_red = {[2] = {model = "models/tnb/clothing/trp/body/%s_rebel.mdl", skin = 2}},
		clothing_parka_teal = {[2] = {model = "models/tnb/clothing/trp/body/%s_rebel.mdl", skin = 1}},
		clothing_survivor = {[2] = {model = "models/tnb/clothing/trp/body/%s_survivor.mdl", skin = 1}},
		clothing_trenchcoat_black = {[2] = {model = "models/tnb/clothing/trp/body/%s_marcus.mdl"}},
		clothing_trenchcoat_brown = {[2] = {model = "models/tnb/clothing/trp/body/%s_marcus.mdl", skin = 1}},
		clothing_workshirt = {[2] = {model = "models/tnb/clothing/trp/body/%s_workshirt.mdl"}},
	}
}

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	table.insert(tab, {
		Name = "Redeem",
		Func = function(item, user)
			if CLIENT then
				GAMEMODE:OpenOutfitterUI(self)
			end
		end
	})

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end

if CLIENT then
	function GM:OpenOutfitterUI(item)
		if IsValid(CCP.PlayerMenu) then
			CCP.PlayerMenu:Close()
		end

		CCP.Outfitter = vgui.Create("DFrame")
		CCP.Outfitter:SetSize(300, 500)
		CCP.Outfitter:Center()
		CCP.Outfitter:SetTitle("Outfitter")
		CCP.Outfitter.lblTitle:SetFont("CombineControl.Window")
		CCP.Outfitter:MakePopup()
		CCP.Outfitter.PerformLayout = CCFramePerformLayout
		CCP.Outfitter:PerformLayout()

		CCP.Outfitter.Think = UIAutoClose

		CCP.Outfitter.OnKeyCodePressed = function(pnl, key)
			if input.LookupKeyBinding(key) and string.find(input.LookupKeyBinding(key), "showspare1") then
				pnl:Close()

				GAMEMODE.CursorItem = nil
			end
		end

		CCP.Outfitter.Submit = vgui.Create("DButton", CCP.Outfitter)
		CCP.Outfitter.Submit:SetFont("CombineControl.LabelSmall")
		CCP.Outfitter.Submit:SetText("Submit")
		CCP.Outfitter.Submit:DockMargin(5, 0, 5, 5)
		CCP.Outfitter.Submit:Dock(BOTTOM)
		CCP.Outfitter.Submit:SetDisabled(true)

		function CCP.Outfitter.Submit:DoClick()
			net.Start("nOutfitterRedeem")
				net.WriteUInt(item.ID, 32)

				for k in pairs(item.Options) do
					local opt = CCP.Outfitter.Groups[k]:GetSelected()

					net.WriteString(opt or "")
				end

			net.SendToServer()

			CCP.Outfitter:Close()
			GAMEMODE:CreatePlayerMenu()
		end

		CCP.Outfitter.Groups = {}

		for i, group in SortedPairs(item.Options, true) do
			local panel = vgui.Create("DComboBox", CCP.Outfitter)

			panel:DockMargin(5, 0, 5, 5)
			panel:Dock(BOTTOM)
			panel:SetTall(20)

			panel:PerformLayout()

			panel:AddChoice("*None*", false, true)

			for k, v in pairs(group) do
				panel:AddChoice(k, v)
			end

			panel.OnSelect = function()
				CCP.Outfitter.Submit:SetDisabled(false)
				CCP.Outfitter:Refresh()
			end

			CCP.Outfitter.Groups[i] = panel
		end

		function CCP.Outfitter:Refresh()
			local data = {
				[1] = {
					model = LocalPlayer():GetModel(),
					skin = LocalPlayer():GetSkin()
				},
				[2] = {
					model = string.format("models/tnb/clothing/trp/body/%s_survivor.mdl", LocalPlayer():Gender())
				}
			}

			for _, v in pairs(CCP.Outfitter.Groups) do
				local _, opt = v:GetSelected()

				if opt then
					table.Merge(data, table.Copy(opt))
				end
			end

			for _, v in pairs(data) do
				if string.find(v.model, "%s", 1, true) then
					v.model = string.format(v.model, LocalPlayer():Gender())
				end
			end

			CCP.Outfitter.CharacterModel:SetModel(data[1].model)

			compound.SetCompoundModel(CCP.Outfitter.CharacterModel.Entity, unpack(data))
			compound.HideCompoundModel(CCP.Outfitter.CharacterModel.Entity, true)

			CCP.Outfitter.CharacterModel.Entity:SetNoDraw(true)
		end

		CCP.Outfitter.CharacterModel = vgui.Create("DModelPanel", CCP.Outfitter)
		CCP.Outfitter.CharacterModel:SetModel(LocalPlayer():GetModel())
		CCP.Outfitter.CharacterModel:DockMargin(5, 5, 5, 5)
		CCP.Outfitter.CharacterModel:Dock(FILL)
		CCP.Outfitter.CharacterModel:SetFOV(20)
		CCP.Outfitter.CharacterModel:SetCamPos(Vector(120, 0, 60))
		CCP.Outfitter.CharacterModel:SetLookAt(Vector(0, 0, 50))
		CCP.Outfitter.CharacterModel.PreDrawModel = compound.DrawClientAttachments

		function CCP.Outfitter.CharacterModel:LayoutEntity(ent)
			ent:SetEyeTarget(Vector(120, 0, 60))
		end

		function CCP.Outfitter.CharacterModel.Entity:GetPlayerColor()
			if not LocalPlayer() or not LocalPlayer():IsValid() then return Vector(1, 1, 1) end

			return LocalPlayer():GetPlayerColor()
		end

		CCP.Outfitter:Refresh()
	end
else
	util.AddNetworkString("nOutfitterRedeem")

	net.Receive("nOutfitterRedeem", function(_, ply)
		local item = GAMEMODE:GetItem(net.ReadUInt(32))

		if not item or not item.Options then
			return
		end

		for _, v in pairs(item.Options) do
			local choice = net.ReadString()

			if not v[choice] then
				continue
			end

			ply:GiveItem(choice, 1)
		end

		GAMEMODE:DeleteItem(item)
	end)
end
