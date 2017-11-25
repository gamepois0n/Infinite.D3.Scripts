UIControlHelper = {}
UIControlHelper.UIControls = Infinity.D3.GetUIControls()
UIControlHelper.Root = UIControlHelper.UIControls["Root"]

function UIControlHelper.GetAllUIControls()
	return UIControlHelper.UIControls
end

function UIControlHelper.GetUIControlByName(name)
	return UIControlHelper.UIControls[name]
end

function UIControlHelper.TranslatePointToControlRect(vec2, control)
	local root = UIControlHelper.Root

	local uiRoot = root:GetUIRect()
	local uiControl = control:GetUIRect()
	local uiClient = Infinity.D3.GetClientRect()

	
end