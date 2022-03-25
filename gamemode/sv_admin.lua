local GM = GM or GAMEMODE
net.Receive("nGetBansList", function(len, ply)
	if not ply:IsAdmin() then return end

	net.Start("nBansList")
		net.WriteTable(GAMEMODE.BanTable or {})
	net.Send(ply)
end)

net.Receive("nDisableOOC", function(len, ply)
	if not ply:IsAdmin() then
		return
	end

	GAMEMODE:SetOOCDisabled(not GAMEMODE:OOCDisabled())

	net.Start("nAddNotification")
		net.WriteString(string.format("%s has %s OOC", ply:Nick(), GAMEMODE:OOCDisabled() and "disabled" or "enabled"))
	net.Broadcast()
end)

function concommand.AddAdminVariable(cmd, var, default, friendlyvar, sa)
	local function c(ply, _, args)

		if not ply:IsAdmin() then
			ply:SendChat(nil, "ERROR", "You need to be an admin to do this")

			return
		end

		if sa and not ply:IsSuperAdmin() then
			ply:SendChat(nil, "ERROR", "You need to be a superadmin to do this")

			return
		end

		if not args[1] then
			ply:SendChat(nil, "ERROR", "Error: No value specified.")

			return
		end

		GAMEMODE["Set" .. var](GAMEMODE, tonumber(args[1]))

		GAMEMODE:LogAdmin("[V] " .. ply:Nick() .. " set variable \"" .. var .. "\" to \"" .. tonumber(args[1]) .. "\".", ply)

		net.Start("nAUpdateAdminVariable")
			net.WriteEntity(ply)
			net.WriteFloat(tonumber(args[1]))
			net.WriteString(friendlyvar)
		net.Broadcast()

	end
	concommand.Add(cmd, c)
end

concommand.AddAdminVariable("rpa_oocdelay", "OOCDelay", 0, "OOC delay")
