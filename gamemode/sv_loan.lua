net.Receive("nTakeLoan", function(len, ply)
	local amt = net.ReadUInt(10)
	local loan = ply:Loan()
	local money = ply:Money()

	if loan + amt > GAMEMODE.MaxLoan then
		return
	end

	ply:SetLoan(loan + amt)
	ply:SetMoney(money + amt)

	ply:UpdateCharacterField("Loan", tostring(ply:Loan()))
	ply:UpdateCharacterField("Money", tostring(ply:Money()))
end)

net.Receive("nGiveLoan", function(len, ply)
	local amt = net.ReadUInt(10)
	local loan = ply:Loan()
	local money = ply:Money()

	if amt > loan or amt > money then
		return
	end

	ply:SetLoan(math.max(loan - amt, 0))
	ply:SetMoney(math.max(money - amt, 0))

	ply:UpdateCharacterField("Loan", tostring(ply:Loan()))
	ply:UpdateCharacterField("Money", tostring(ply:Money()))
end)

net.Receive("nDeductLoan", function(len, ply)
	if not flag or not flag.CanEditLoans then
		return
	end

	local targ = net.ReadEntity()
	local i = net.ReadUInt(10)

	targ:SetLoan(math.max(targ:Loan() - i, 0))
	targ:UpdateCharacterField("Loan", tostring(targ:Loan()))

	GAMEMODE:LogCombine("[L] " .. ply:VisibleRPName() .. " deducted " .. i .. " dollars from " .. targ:VisibleRPName() .. "'s loan.", ply)
end)
