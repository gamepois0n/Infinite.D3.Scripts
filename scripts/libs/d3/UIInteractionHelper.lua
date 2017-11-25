UIInteractionHelper = {}
UIInteractionHelper.AllUIInteractionFunctions = Infinity.D3.GetAllUIInteractionFunctions()

function UIInteractionHelper.GetAllFunctions()
	return UIInteractionHelper.AllUIInteractionFunctions
end

function UIInteractionHelper.UseFunctionByName(name)
	local func = UIInteractionHelper.AllUIInteractionFunctions[name]

	if func == nil then
		return
	end

	func:Use()
end