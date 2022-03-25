class = {}

function class.Register(classname, tab)
	tab._class = classname

	baseclass.Set(classname, tab)

	MsgC(Color(200, 200, 200, 255), string.format("Registered class: %s\n", classname))
end

function class.Exists(classname)
	return table.Count(baseclass.Get(classname)) > 0 and true or false
end

function class.Instance(classname, ...)
	assertf(class.Exists(classname), "Attempt to instantiate non-existant class '%s'", classname)

	local obj = setmetatable({}, {
		__index = baseclass.Get(classname)
	})

	if obj._init then
		obj:_init(...)
	end

	return obj
end

function class.IsTypeOf(obj, classname)
	assertf(class.Exists(classname), "Attempt to compare object '%s' with non-existant class '%s'", tostring(obj), classname)

	return obj:_istype(baseclass.Get(classname))
end

function class.IsChildOf(classname, parent)
	local meta = baseclass.Get(classname)
	local base = baseclass.Get(parent)

	while meta do
		if meta == base then
			return true
		end

		meta = meta._base
	end

	return false
end

function class.Create(parent)
	local tab = {}

	if isstring(parent) then
		parent = baseclass.Get(parent)
	end

	if istable(parent) then
		tab._base = parent

		setmetatable(tab, {
			__index = parent
		})
	end

	tab._istype = function(self, obj)
		local m = getmetatable(self).__index

		while m do
			if m == obj then
				return true
			end

			m = m._base
		end

		return false
	end

	tab.GetClass = function(self)
		return self._class
	end

	return tab
end
