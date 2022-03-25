AddCSLuaFile()

-- Write to a file, making sure that the directories exist and the file path contains
-- no invalid characters.
function file.WriteSafe(filename, contents)
	filename = file.GetSafeFilename(filename)

	-- Make sure the directory exists.
	local dir = string.GetPathFromFilename(filename)
	if not file.Exists(dir, "DATA") then
		file.CreateDir(dir)
	end

	-- Open, write, close
	local logfile = file.Open(filename, "w", "DATA")
	assert(logfile, 'Couldn\'t open file for writing: "' .. filename .. '"')

	logfile:Write(contents .. "\n")
	logfile:Close()
end

-- Ditto, for appending
function file.AppendSafe(filename, contents)
	filename = file.GetSafeFilename(filename)

	-- Make sure the directory exists
	local dir = string.GetPathFromFilename(filename)
	if not file.Exists(dir, "DATA") then
		file.CreateDir(dir)
	end

	local logfile = file.Open(filename, "a", "DATA")
	assert(logfile, 'Couldn\'t open file for appending: "' .. filename .. '"')

	logfile:Write(contents .. "\n")
	logfile:Close()
end

-- Strips or replaces unsafe characters for a filename
function file.GetSafeFilename(filename)
	filename = string.match(filename, "(.*)%.txt$")
	return string.gsub(string.gsub(filename, "[^\32-\126]", ""), "[^%w-_/]", "_") .. ".txt"
end
