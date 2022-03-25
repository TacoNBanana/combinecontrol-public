if CLIENT then
	function GM:OpenDevUI()
		CCP.DevUI = vgui.Create("DFrame")
		CCP.DevUI:SetSize(800, 500)
		CCP.DevUI:Center()
		CCP.DevUI:SetTitle("Developer Panel")
		CCP.DevUI.lblTitle:SetFont("CombineControl.Window")
		CCP.DevUI:MakePopup()
		CCP.DevUI.PerformLayout = CCFramePerformLayout
		CCP.DevUI:PerformLayout()

		CCP.DevUI.OnKeyCodePressed = function(pnl, key)
			if input.LookupKeyBinding(key) and string.find(input.LookupKeyBinding(key), "showspare2") then
				pnl:Close()

				GAMEMODE.CursorItem = nil
			end
		end

		CCP.DevUI.Multiline = vgui.Create("DTextEntry", CCP.DevUI)
		CCP.DevUI.Multiline:SetFont("CombineControl.LabelMedium")
		CCP.DevUI.Multiline:SetPos(10, 35)
		CCP.DevUI.Multiline:SetSize(780, 430)
		CCP.DevUI.Multiline:SetMultiline(true)

		CCP.DevUI.Multiline:SetText(cookie.GetString("cc_dev_history", ""))

		CCP.DevUI.TargetSelect = vgui.Create("DComboBox", CCP.DevUI)
		CCP.DevUI.TargetSelect:SetPos(10, 470)
		CCP.DevUI.TargetSelect:SetSize(180, 20)

		for _, v in pairs(player.GetAll()) do
			if v:CharID() != -1 then
				CCP.DevUI.TargetSelect:AddChoice(string.format("%s (%s)", v:VisibleRPName(), v:Nick()), v)
			end
		end

		CCP.DevUI.TargetSelect:AddChoice("*SERVER*", NULL, true)

		CCP.DevUI.RunButton = vgui.Create("DButton", CCP.DevUI)
		CCP.DevUI.RunButton:SetFont("CombineControl.LabelSmall")
		CCP.DevUI.RunButton:SetText("Run code")
		CCP.DevUI.RunButton:SetPos(200, 470)
		CCP.DevUI.RunButton:SetSize(100, 20)

		CCP.DevUI.RunButton.DoClick = function(pnl)
			net.Start("nRunDebug")
				net.WriteEntity(select(2, CCP.DevUI.TargetSelect:GetSelected()))
				net.WriteString(CCP.DevUI.Multiline:GetValue())
			net.SendToServer()

			cookie.Set("cc_dev_history", CCP.DevUI.Multiline:GetValue())
		end
	end
else
	util.AddNetworkString("nRunDebug")
	util.AddNetworkString("nDebugRelay")
	util.AddNetworkString("nDebugOutput")

	concommand.Add("dev_runlua", function(ply, cmd, args, argStr)
		if IsValid(ply) then
			ply:PrintMessage(HUD_PRINTCONSOLE, "Unknown command: dev_runlua")

			return
		end

		GAMEMODE:RunDebug(nil, argStr)
	end)

	concommand.Add("dev_runcl", function(ply, cmd, args, argStr)
		if IsValid(ply) then
			ply:PrintMessage(HUD_PRINTCONSOLE, "Unknown command: dev_runcl")

			return
		end

		local target = GAMEMODE:FindPlayer(args[1], nil)

		if not target then
			print("Error: No target found")

			return
		end

		net.Start("nRunDebug")
			net.WriteEntity(NULL)
			net.WriteString(string.sub(argStr, #args[1] + 1))
		net.Send(target)
	end)
end

local receivers = {
	print = function(ply, ...)
		local args = {...}

		if IsValid(ply) then
			table.insert(args, 1, string.format("[%s|%s]", ply:VisibleRPName(), ply:Nick()))
		else
			table.insert(args, 1, "[SERVER]")
		end

		print(unpack(args))
	end,
	PrintTable = function(ply, ...)
		if IsValid(ply) then
			print(string.format("[%s|%s]", ply:VisibleRPName(), ply:Nick()))
		else
			print("[SERVER]")
		end

		PrintTable(...)
	end
}

function GM:HandleDebugOutput(func, args, target, from)
	if not receivers[func] then
		return
	end

	if CLIENT then
		net.Start("nDebugRelay")
			net.WriteString(func)
			net.WriteTable(args)
			net.WriteEntity(target or NULL)
		net.SendToServer()
	else
		if not IsValid(target) then
			receivers[func](from, unpack(args))
		else
			net.Start("nDebugOutput")
				net.WriteString(func)
				net.WriteTable(args)
				net.WriteEntity(from)
			net.Send(target)
		end
	end
end

function GM:RunDebug(ply, str)
	if IsValid(ply) and not ply:IsDeveloper() then
		return
	end

	local func = CompileString(str, "@" .. (IsValid(ply) and ply:SteamID() or "SERVER"), false)

	if isfunction(func) then
		local tab = {
			print = function(...)
				GAMEMODE:HandleDebugOutput("print", {...}, ply)
			end,
			PrintTable = function(...)
				GAMEMODE:HandleDebugOutput("PrintTable", {...}, ply)
			end,
			printf = function(...)
				GAMEMODE:HandleDebugOutput("print", {string.format(...)}, ply)
			end
		}

		if IsValid(ply) then
			tab.ply = ply
			tab.this = ply:GetEyeTrace().Entity
		end

		if CLIENT then
			tab.lp = LocalPlayer()
		else
			tab.SetPlayerField = function(targ, key, val)
				targ["Set" .. key](targ, val)
				targ:UpdatePlayerField(key, val)
			end
		end

		setfenv(func, setmetatable(tab, {__index = _G}))

		local _, res = pcall(func)

		if res then
			self:HandleDebugOutput("print", {res}, ply)
		end
	end
end

if CLIENT then
	net.Receive("nDebugOutput", function()
		local func = net.ReadString()
		local args = net.ReadTable()
		local ent = net.ReadEntity()

		if not receivers[func] then
			return
		end

		receivers[func](ent, unpack(args))
	end)

	net.Receive("nRunDebug", function()
		local ply = net.ReadEntity()
		local str = net.ReadString()

		GAMEMODE:RunDebug(ply, str)
	end)
else
	net.Receive("nRunDebug", function(_, ply)
		if not ply:IsDeveloper() then
			GAMEMODE:AddBan(ply:SteamID(), 0, "Unauthorized debug attempt")

			return
		end

		local target = net.ReadEntity()
		local str = net.ReadString()

		if IsValid(target) then
			net.Start("nRunDebug")
				net.WriteEntity(ply)
				net.WriteString(str)
			net.Send(target)
		else
			GAMEMODE:RunDebug(ply, str)
		end
	end)

	net.Receive("nDebugRelay", function(_, ply)
		local func = net.ReadString()
		local args = net.ReadTable()
		local targ = net.ReadEntity()

		GAMEMODE:HandleDebugOutput(func, args, targ, ply)
	end)
end
