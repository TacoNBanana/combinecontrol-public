function GM:MapInitPostEntity()
        self:CreateLocationPoint(Vector(-2917.242432, 989.487183, 224.676270), LOCATION_CANALS, 300, TRANSITPORT_CANALS_ENTRY)
end
 
GM.EntryPortSpawns[TRANSITPORT_CANALS_ENTRY] = {
        Vector(-2867, 258, 512),
        Vector(-2860, 121, 428),
        Vector(-2846, 16, 478),
        Vector(-2832, 411, 325),
        Vector(-2499, -178, 422),

}
GM.EntryPortSpawns[TRANSITPORT_COAST_ENTRY] = {
	Vector(8734, -87, -2404),
	Vector(8733, 31, -2405),
	Vector(8704, 124, -2403)

}
 
GM.EnableAreaportals = true
 
GM.ConnectMessages[TRANSITPORT_CANALS_ENTRY] = "If you crawl back through the mines, you'll find yourself back in the lightly patrolled canals..."
GM.ConnectMessages[TRANSITPORT_COAST_ENTRY] = "Past this large metal door and through many miles of forest, you can reach the city's canal system."
 
GM.CurrentLocation = LOCATION_CAVES






