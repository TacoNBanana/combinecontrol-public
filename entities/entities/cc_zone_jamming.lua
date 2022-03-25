AddCSLuaFile()
DEFINE_BASECLASS("cc_zone")

ENT.Base 			= "cc_zone"

ENT.PrintName 		= "Radio jamming zone"
ENT.Category 		= "CombineControl - Zones"

ENT.Spawnable 		= true
ENT.AdminSpawnable 	= true

ENT.Color 			= Color(127, 159, 255)

function ENT:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Int", 1, "Severity")
end

function ENT:GetContextOptions(ply)
	local tab = BaseClass.GetContextOptions(self, ply)

	if ply:IsAdmin() and not self:IsReady() then
		table.insert(tab, {
			Name = "Set severity",
			Client = function()
				local ent = self
				local ui = vgui.Create("DFrame")

				ui:SetSize(150, 74)
				ui:Center()
				ui:SetTitle("Severity")
				ui.lblTitle:SetFont("CombineControl.Window")
				ui:MakePopup()
				ui.PerformLayout = CCFramePerformLayout
				ui:PerformLayout()

				ui.Think = UIAutoClose

				ui.Amount = vgui.Create("DTextEntry", ui)
				ui.Amount:SetPos(10, 34)
				ui.Amount:SetSize(60, 30)
				ui.Amount:SetFont("CombineControl.LabelSmall")
				ui.Amount:PerformLayout()
				ui.Amount:SetValue(self:GetSeverity())
				ui.Amount:SetCaretPos(1)
				ui.Amount:RequestFocus()

				function ui.Amount:AllowInput(val)
					if not string.find(val, "%d") then
						return true
					end
				end

				ui.Submit = vgui.Create("DButton", ui)
				ui.Submit:SetPos(80, 34)
				ui.Submit:SetSize(60, 30)
				ui.Submit:SetFont("CombineControl.LabelSmall")
				ui.Submit:SetText("Submit")
				ui.Submit:PerformLayout()

				function ui.Submit:DoClick()
					local val = tonumber(ui.Amount:GetValue())

					if not val or val <= 0 then
						return
					end

					net.Start("nSetJamValue")
						net.WriteEntity(ent)
						net.WriteUInt(math.Clamp(math.Round(val), 0, 100), 7)
					net.SendToServer()

					ui:Close()
				end

				ui.Amount.OnEnter = ui.Submit.DoClick
			end
		})
	end

	return tab
end

function ENT:GetZOrder()
	return self:GetSeverity()
end

if CLIENT then
	function ENT:Draw()
		BaseClass.Draw(self)

		if GAMEMODE.SeeAll and LocalPlayer():IsAdmin() then
			GAMEMODE:DrawWorldText(self:WorldSpaceCenter(), string.format("Severity: %i", self:GetSeverity()), true)
		end
	end
end

if SERVER then
	util.AddNetworkString("nSetJamValue")

	net.Receive("nSetJamValue", function(len, ply)
		if not ply:IsAdmin() then
			return
		end

		net.ReadEntity():SetSeverity(net.ReadUInt(7))
	end)

	function ENT:GetCustomData()
		return {
			Severity = self:GetSeverity(),

			ZoneMins = self:GetZoneMins(),
			ZoneMaxs = self:GetZoneMaxs()
		}
	end

	function ENT:LoadCustomData(data)
		self:SetSeverity(data.Severity)

		self:SetZoneMins(data.ZoneMins)
		self:SetZoneMaxs(data.ZoneMaxs)
	end
end
