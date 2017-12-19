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

function UIControlHelper.GetPortraitUIRectByIndex(index)
	local control = UIControlHelper.GetUIControlByName("Root.NormalLayer.portraits.stack.party_stack.portrait_" .. index .. ".icon")

	if control == nil then
		return nil
	end

	return control:GetUIRect()
end

function UIControlHelper.GetUIControlByItemLocation(itemlocation)
	if itemlocation == 1 then --PlayerHead
		return UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage.inventory_button_head")
	elseif itemlocation == 2 then --PlayerTorso
		return UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage.inventory_button_torso")
	elseif itemlocation == 3 then --PlayerRightHand
		return UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage.inventory_button_armRight")
	elseif itemlocation == 4 then --PlayerLeftHand
		return UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage.inventory_button_armLeft")
	elseif itemlocation == 5 then --PlayerHands
		return UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage.inventory_button_hands")
	elseif itemlocation == 6 then --PlayerWaist
		return UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage.inventory_button_waist")
	elseif itemlocation == 7 then --PlayerFeet
		return UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage.inventory_button_feet")
	elseif itemlocation == 8 then --PlayerShoulders
		return UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage.inventory_button_shoulders")
	elseif itemlocation == 9 then --PlayerLegs
		return UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage.inventory_button_legs")
	elseif itemlocation == 10 then --PlayerBracers
		return UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage.inventory_button_bracers")
	elseif itemlocation == 11 then --PlayerLeftFinger
		return UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage.inventory_button_fingerLeft")
	elseif itemlocation == 12 then --PlayerRightFinger
		return UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage.inventory_button_fingerRight")
	elseif itemlocation == 13 then --PlayerNeck
		return UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage.inventory_button_neck")
	end

	return nil;
end