ParagonPointHelper = {}
ParagonPointHelper.ParagonPointWindow = Infinity.D3.GetParagonPointWindow()

function ParagonPointHelper.OpenParagonPointSelect()
	UIInteractionHelper.UseFunctionByName("UIParagon_Toggle")
end

function ParagonPointHelper.ResetCurrentTab()
	UIInteractionHelper.UseFunctionByName("UIParagon_OnClick_ResetParagonPointsButton")
end

function ParagonPointHelper.ApplyPoints()
	UIInteractionHelper.UseFunctionByName("UIParagon_OnClick_ParagonAssignPointsButton")
end

function ParagonPointHelper.SetMainstat(value)
	ParagonPointHelper.ParagonPointWindow:SetStrength(value)
end

function ParagonPointHelper.SetVitality(value)
	ParagonPointHelper.ParagonPointWindow:SetVitality(value)
end

function ParagonPointHelper.SetMovementSpeed(value)
	if value > 50 then
		value = 50
	end

	ParagonPointHelper.ParagonPointWindow:SetMovementSpeed(value)
end

function ParagonPointHelper.SetMaxResource(value)
	if value > 50 then
		value = 50
	end

	ParagonPointHelper.ParagonPointWindow:SetMaxResource(value)
end