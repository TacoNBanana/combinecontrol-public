local function handleSoundMenuClick(catindex, soundindex, dispatch)
	local cmd = dispatch and "rp_playdispatch" or "rp_playsound"
	local prefix = dispatch and "/rdis " or ""

	local data = GAMEMODE.SoundData[catindex].sounds[soundindex]

	RunConsoleCommand(cmd, catindex, soundindex)
	if data[3] and cookie.GetNumber("cc_playsoundssay", 1) == 1 then
		GAMEMODE:ParseChat(prefix .. data[3])
	end
end

function GM:GenerateSoundMenu(contextMenu)
	local soundMenu = nil
	local dispatchMenu = nil

	local function menuClose()
		gui.EnableScreenClicker(false)
	end

	for catindex, category in ipairs(self.SoundData) do
		local dispatch = category.dispatch

		if self:CanPlaySound(LocalPlayer(), category) then
			if not soundMenu then
				soundMenu = contextMenu:AddSubMenu("Sounds", menuClose)
			end

			if dispatch and not dispatchMenu then
				dispatchMenu = soundMenu:AddSubMenu("DISPATCH", menuClose)
			end

			local subMenu = (dispatch and dispatchMenu or soundMenu):AddSubMenu(category.name, menuClose)

			for soundindex, soundBlock in ipairs(category.sounds) do
				subMenu:AddOption(soundBlock[2], function()
					gui.EnableScreenClicker(false)
					handleSoundMenuClick(catindex, soundindex, dispatch)
				end)
			end
		end
	end
end

net.Receive("nPlaySoundRange", function(len)
	local pos = net.ReadVector()
	local range = net.ReadInt(32)
	local snd = net.ReadString()

	local dist = LocalPlayer():EyePos():Distance(pos)

	dist = math.Remap(dist, 0, 10000 + range, 1, 0)
	dist = math.Clamp(dist, 0, 1)

	if dist > 0 then
		LocalPlayer():EmitSound(snd, 100, 100, dist)
	end
end)