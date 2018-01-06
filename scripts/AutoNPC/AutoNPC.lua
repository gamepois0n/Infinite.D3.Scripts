AutoNPC = { }
AutoNPC.Running = false
AutoNPC.Settings = Settings()
AutoNPC.Collector = Collector()
AutoNPC.LocalData = Infinity.D3.GetLocalData()

AutoNPC.SalvageDone = false

function AutoNPC.Start()
  AutoNPC.Running = true

  AutoNPCSettings.LoadSettings()
end

function AutoNPC.Stop()
  AutoNPC.Running = false

  AutoNPCSettings.SaveSettings()
end

function AutoNPC.GetRandomItemActorSNO()
  local active = {}

  for k,v in pairs(AutoNPC.Settings.Gamble) do
    if type(v) == "table" then
      if v.Enabled then
        table.insert(active, v.ActorSNO)
      end
    end
  end

  local rngIndex = math.random(table.length(active))

  return active[rngIndex]  
end

function AutoNPC.DoRandomGamble()
  local control = UIControlHelper.GetUIControlByName("Root.NormalLayer.shop_dialog_mainPage")

  if control == nil or not control:GetIsVisible() then
    return
  end

  local rndActorSNO = AutoNPC.GetRandomItemActorSNO()
  --print(rndActorSNO)
  for k,v in pairs(AutoNPC.Collector.Actors.Item.Gamble) do
    if v:GetActorSNO() == rndActorSNO then
      Infinity.D3.BuyItem(v.Address)
      return
    end
  end
end

function AutoNPC.DoSalvage()
  local control = UIControlHelper.GetUIControlByName("Root.NormalLayer.vendor_dialog_mainPage.salvage_dialog")

  if control == nil or not control:GetIsVisible() then
    AutoNPC.SalvageDone = false
    return
  end

  if AutoNPC.SalvageDone then
    return
  end

  for k,v in pairs(AutoNPC.Collector.Actors.Item.Backpack) do
    if AutoNPC.Settings.Salvage.White.Enabled and AttributeHelper.IsWhiteItem(v) and AttributeHelper.GetAttributeValue(v, Enums.AttributeId.ItemStackQuantityLo, -1) <= 0 then
      Infinity.D3.SalvageItem(v.Address, AutoNPC.Collector.LocalACD.Address)
    elseif AutoNPC.Settings.Salvage.Magic.Enabled and AttributeHelper.IsMagicItem(v) and AttributeHelper.GetAttributeValue(v, Enums.AttributeId.ItemStackQuantityLo, -1) <= 0 then
      Infinity.D3.SalvageItem(v.Address, AutoNPC.Collector.LocalACD.Address)
    elseif AutoNPC.Settings.Salvage.Rare.Enabled and AttributeHelper.IsRareItem(v) and AttributeHelper.GetAttributeValue(v, Enums.AttributeId.ItemStackQuantityLo, -1) <= 0 then
      Infinity.D3.SalvageItem(v.Address, AutoNPC.Collector.LocalACD.Address)
    elseif AutoNPC.Settings.Salvage.LegendaryNormal.Enabled and AttributeHelper.IsLegendaryItem(v) and v:GetActorSNO() ~= 403611  and AttributeHelper.IsNormalLegendaryItem(v) and not AttributeHelper.IsSpecialPotion(v) and string.find(v:GetName(), "Unique_Gem") == nil then
      v:SetAttributeValue(Enums.AttributeId.Item_Quality_Level, -1, 0)
      v:SetGameBalanceID(1565454583)

      Infinity.D3.SalvageItem(v.Address, AutoNPC.Collector.LocalACD.Address)
    end
  end

  AutoNPC.SalvageDone = true
end

function AutoNPC.OnPulse()
  if AutoNPC.Running == false then
    return
  end
  
  AutoNPC.Collector:Collect(false, false, false, 5)

  if not AutoNPC.LocalData:GetIsPlayerValid() or AutoNPC.LocalData:GetIsStartUpGame() or UIControlHelper.ReloadRequired then
    return
  end

  if AttributeHelper.IsInTown(AutoNPC.Collector.LocalACD) then
    AutoNPC.DoRandomGamble()
    AutoNPC.DoSalvage()
  end 
end

function AutoNPC.OnRenderD2D()
end