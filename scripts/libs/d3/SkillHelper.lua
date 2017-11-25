SkillHelper = {}

function SkillHelper.GetActiveSkill(powerSno)
	local skill = Infinity.D3.GetActiveSkills()[powerSno]

	if skill == nil then
		return nil
	end

	return {PowerSNO = powerSno, Rune = skill}
end

function SkillHelper.GetActiveSkills()
	local t = {}

	for k,v in pairs(Infinity.D3.GetActiveSkills()) do
		table.insert(t, {PowerSNO = k, Rune = v})
	end

	return t
end

function SkillHelper.GetPassiveSkills()
	return Infinity.D3.GetPassiveSkills()
end

function SkillHelper.IsPassiveEquipped(powerSno)
	local skill = Infinity.D3.GetPassiveSkills()[powerSno]

	if skill == nil then
		return false
	end

	return true
end

function SkillHelper.IsOnCooldown(powerSno)	
	return AttributeHelper.GetAttributeValue(Infinity.D3.GetLocalACD(), Enums.AttributeId.Power_Cooldown, powerSno) ~= -1
end

function SkillHelper.ChangeActiveSkill(slot, powerSno, rune)
	Infinity.D3.SetActiveSkill(slot, powerSno, rune)

	UIInteractionHelper.UseFunctionByName("UISkillsPane_OnClick_AcceptActiveSkillsButton")
end

function SkillHelper.ChangePassiveSkill(slot, powerSNO)
	Infinity.D3.SetPassiveSkill(slot, powerSNO)

	UIInteractionHelper.UseFunctionByName("UISkillsPane_OnClick_AcceptPassiveSkillsButton")
end