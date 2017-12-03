UIControlHelper = {}
UIControlHelper.UIControls = Infinity.D3.GetUIControls()
UIControlHelper.Root = UIControlHelper.UIControls["Root"]
UIControlHelper.LocalData = Infinity.D3.GetLocalData()
UIControlHelper.ReloadRequired = false

function UIControlHelper.Reload()
	if not UIControlHelper.ReloadRequired and UIControlHelper.LocalData:GetIsStartUpGame() and not UIControlHelper.LocalData:GetIsPlayerValid() then
		print("UIControl Reload required!")
		UIControlHelper.ReloadRequired = true
	end

	if UIControlHelper.ReloadRequired and not UIControlHelper.LocalData:GetIsStartUpGame() and UIControlHelper.LocalData:GetIsPlayerValid() then
		UIControlHelper.ReloadRequired = false

		print("Reloading UIControls!")
		UIControlHelper.UIControls = Infinity.D3.GetUIControls()
	end
end

function UIControlHelper.GetAllUIControls()
	return UIControlHelper.UIControls
end

function UIControlHelper.GetUIControlByName(name)
	return UIControlHelper.UIControls[name]
end