AutoGamble = { }
AutoGamble.Running = false
AutoGamble.Settings = Settings()
AutoGamble.Collector = Collector()

function AutoGamble.Start()
  AutoGamble.Running = true

  AutoGambleSettings.LoadSettings()
end

function AutoGamble.Stop()
  AutoGamble.Running = false

  AutoGambleSettings.SaveSettings()
end

function AutoGamble.GetRandomItemActorSNO()
  local active = {}

  for k,v in pairs(AutoGamble.Settings) do
    if type(v) == "table" then
      if v.Enabled then
        table.insert(active, v.ActorSNO)
      end
    end
  end

  local rngIndex = math.random(table.length(active))

  return active[rngIndex]  
end

function AutoGamble.DoRandomGamble()
  local control = UIControlHelper.GetUIControlByName("Root.NormalLayer.shop_dialog_mainPage")

  if control == nil or not control:GetIsVisible() then
    return
  end

  local rndActorSNO = AutoGamble.GetRandomItemActorSNO()
  --print(rndActorSNO)
  for k,v in pairs(AutoGamble.Collector.Actors.Item.Gamble) do
    if v:GetActorSNO() == rndActorSNO then
      Infinity.D3.BuyItem(v.Address)
      return
    end
  end
end

function AutoGamble.OnPulse()
  if AutoGamble.Running == false then
    return
  end

  AutoGamble.Collector:Collect(false, false, false, 5)

  if AttributeHelper.IsInTown(AutoGamble.Collector.LocalACD) then
    AutoGamble.DoRandomGamble()
  end 
end

function AutoGamble.OnRenderD2D()
end