hook.Add("NetworkEntityCreated", "CL.Door.NetworkEntityCreated", function(ent)
	if ent:IsDoor() then
		net.Start("nRequestDoorData")
			net.WriteEntity(ent)
		net.SendToServer()
	end
end)