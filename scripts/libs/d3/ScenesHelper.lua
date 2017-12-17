ScenesHelper = {}
--ScenesHelper.CustomNavCells = Infinity.D3.GetCustomNavCells()

function ScenesHelper.GetCurrentScenes(currentWorldId)
	local t = {}

	for k,v in pairs(Infinity.D3.GetScenes()) do
		if v:GetSWorldID() == currentWorldId then
			table.insert(t, v)
		end
	end

	return t
end

function ScenesHelper.GetNavCellsBySceneSNOID(sceneSnoID)
	return Infinity.D3.GetCustomNavCellsBySNO(sceneSnoID)
end