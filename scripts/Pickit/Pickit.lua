Pickit = { }
Pickit.Running = false
Pickit.Settings = Settings()
Pickit.Collector = Collector()

function Pickit.Start()
  Pickit.Running = true

  PickitSettings.LoadSettings()
end

function Pickit.Stop()
  Pickit.Running = false

  PickitSettings.SaveSettings()
end

function Pickit.TryPickupItems()
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
      end
    end
  end
end

function Pickit.OnPulse()
  if Pickit.Running == false then
    return
  end
  
  Pickit.Collector:Collect(false, false, false)

  --if not AttributeHelper.IsInTown(Pickit.Collector.LocalACD) then
    Pickit.TryPickupItems()
  --end  
end

function Pickit.OnRenderD2D()
end