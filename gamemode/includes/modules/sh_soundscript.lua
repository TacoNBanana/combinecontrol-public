soundscript = {}

local reloadSounds = {
	channel = CHAN_AUTO,
	level = 80,
	volume = 1,
	pitch = 100
}

local fireSounds = {
	channel = CHAN_WEAPON,
	level = 97,
	volume = 1,
	pitch = {92, 112}
}

local miscSounds = {
	channel = CHAN_AUTO,
	level = 65,
	volume = 1,
	pitch = {92, 112}
}

function soundscript.MakeDirectional(snd)
	if istable(snd) then
		for k, v in pairs(snd) do
			snd[k] = ")" .. v
		end
	else
		snd = ")" .. snd
	end

	return snd
end

function soundscript.AddSound(partial, options)
	local tab = table.Copy(partial)

	table.Merge(tab, options)
	sound.Add(tab)

	if istable(tab.sound) then
		for _, v in pairs(tab.sound) do
			util.PrecacheSound(v)
		end
	else
		util.PrecacheSound(tab.sound)
	end

	return tab.name
end

function soundscript.AddReload(name, snd)
	snd = soundscript.MakeDirectional(snd)

	local tab = {
		name = name,
		sound = snd,
	}

	return soundscript.AddSound(reloadSounds, tab)
end

function soundscript.AddFire(name, snd, level)
	snd = soundscript.MakeDirectional(snd)

	local tab = {
		name = name,
		level = level,
		sound = snd
	}

	return soundscript.AddSound(fireSounds, tab)
end

function soundscript.AddMisc(name, snd)
	soundscript.MakeDirectional(snd)

	local tab = {
		name = name,
		sound = snd
	}

	return soundscript.AddSound(miscSounds, tab)
end