GroundEffectHelper = {}

function GroundEffectHelper.IsPlagued(acd)
	if acd:GetActorSNO() == 108869 or
		acd:GetActorSNO() == 223933 then
		return true
	end

	return false
end

function GroundEffectHelper.IsDesecrator(acd)
	if acd:GetActorSNO() == 84608 or
		acd:GetActorSNO() == 84606 then
		return true
	end

	return false
end

function GroundEffectHelper.IsPoisonEnchanted(acd)
	if acd:GetActorSNO() == 340319 or
		acd:GetActorSNO() == 316389 or
		acd:GetActorSNO() == 384614 or
		acd:GetActorSNO() == 384617 then
		return true
	end

	return false
end

function GroundEffectHelper.IsMolten(acd)
	if --acd:GetActorSNO() == 95868 or
		acd:GetActorSNO() == 247980 or
		acd:GetActorSNO() == 4804 or
		acd:GetActorSNO() == 4803 or
		acd:GetActorSNO() == 224225 or
		acd:GetActorSNO() == 250031 then
		return true
	end

	return false
end

function GroundEffectHelper.IsMortar(acd)
	if acd:GetActorSNO() == 250031 then
		return true
	end

	return false
end

function GroundEffectHelper.IsFrozen(acd)
	if acd:GetActorSNO() == 223675 then
		return true
	end

	return false
end

function GroundEffectHelper.IsWormwhole(acd)
	if acd:GetActorSNO() == 337109 then
		return true
	end

	return false
end

function GroundEffectHelper.IsArcane(acd)
	if acd:GetActorSNO() == 219702 or
		acd:GetActorSNO() == 221225 or
		acd:GetActorSNO() == 221560 or
		acd:GetActorSNO() == 221658 or
		acd:GetActorSNO() == 384431 or
		acd:GetActorSNO() == 384433 or
		acd:GetActorSNO() == 386997 or
		acd:GetActorSNO() == 387010 then
		return true
	end

	return false
end

function GroundEffectHelper.IsOccuCircle(acd)
	if acd:GetActorSNO() == 4176 and AttributeHelper.GetAttributeValue(acd, Enums.AttributeId.Power_Buff_1_Visual_Effect_None, 402461) == 1 then
		return true
	end

	return false
end

function GroundEffectHelper.IsFrozenPulse(acd)
	if acd:GetActorSNO() == 384631 or
		acd:GetActorSNO() == 349774 or
		acd:GetActorSNO() == 349779 or
		acd:GetActorSNO() == 366924 then
		return true
	end

	return false
end

function GroundEffectHelper.IsOrbiter(acd)
	if acd:GetActorSNO() == 343582 or
		acd:GetActorSNO() == 346839 or
		acd:GetActorSNO() == 343539 or
		acd:GetActorSNO() == 346837 or
		acd:GetActorSNO() == 346805 then
		return true
	end

	return false
end

function GroundEffectHelper.IsThunderstorm(acd)
	if acd:GetActorSNO() == 341512 then
		return true
	end

	return false
end