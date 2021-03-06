Pickit = { }
Pickit.Running = false
Pickit.Settings = Settings()
Pickit.Collector = Collector()
Pickit.LocalData = Infinity.D3.GetLocalData()

Pickit.LastPickup = 0

function Pickit.Start()
  Pickit.Running = true

  PickitSettings.LoadSettings()
end

function Pickit.Stop()
  Pickit.Running = false

  PickitSettings.SaveSettings()
end

function Pickit.TryPickupItems()
if Pickit.LastPickup + 50 > Infinity.Win32.GetTickCount() then
  return
end

  for k,v in pairs(Pickit.Collector.Actors.Item.Ground) do
    if v:GetPosition():GetDistanceFromMe() <= Pickit.Settings.PickupRadius then
      local pickup = false
      
      if not pickup and AttributeHelper.IsGemItem(v) and Pickit.Settings.Gem.Enabled then
        pickup = true
      end

      if not pickup and AttributeHelper.IsCraftMaterial(v) and Pickit.Settings.CraftMaterial.Enabled then
        pickup = true
      end

      if not pickup and AttributeHelper.IsRiftKey(v) and Pickit.Settings.RiftKey.Enabled then
        pickup = true
      end

      if not pickup and AttributeHelper.IsWhiteItem(v) and Pickit.Settings.Normal.White then
        pickup = true
      end

      if not pickup and AttributeHelper.IsLegendaryItem(v) then
        if AttributeHelper.IsPrimalLegendaryItem(v) and Pickit.Settings.Legendary.Primal then
          pickup = true
        elseif AttributeHelper.IsAncientLegendaryItem(v) and Pickit.Settings.Legendary.Ancient then
          pickup = true
        elseif Pickit.Settings.Legendary.Normal then
          pickup = true
        end
      end

      if pickup and not AttributeHelper.GizmoHasBeenOperated(v) then
        PickitHelper.PickupItem(RActorHelper.GetRActorByACD(v))

        --TargetMessage:new(2, v:GetANNId(), v:GetPosition(), Pickit.Collector.WorldId, 30021):Send()

        Pickit.LastPickup = Infinity.Win32.GetTickCount()
      end
    end
  end
end

function Pickit.OnPulse()
  if Pickit.Running == false then
    return
  end
    
  Pickit.Collector:Collect(false, false, false, 5)
  
  if not Pickit.LocalData:GetIsPlayerValid() or Pickit.LocalData:GetIsStartUpGame() then
    return
  end
  
  Pickit.TryPickupItems()  
end

function Pickit.OnRenderD2D()
end