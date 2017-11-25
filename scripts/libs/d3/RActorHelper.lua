RActorHelper = {}

function RActorHelper.GetRActorByACD(acd)
	local ractor = Infinity.D3.GetRActorByACDActorId(acd:GetActorId())

	if ractor.Address == 0 then
		return nil
	end

	return ractor
end