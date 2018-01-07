GameBalance = {}
GameBalance.ItemAffixes = Infinity.D3.GetItemAffixes()

function GameBalance.GetItemAffixByGBID(gbid)
	return GameBalance.ItemAffixes[gbid]
end