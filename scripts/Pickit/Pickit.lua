Pickit = { }
Pickit.Running = false
Pickit.Settings = Settings()
Pickit.GroundItems = {}

function Pickit.Start()
  Pickit.Running = true

  PickitSettings.LoadSettings()
end

function Pickit.Stop()
  Pickit.Running = false

  PickitSettings.SaveSettings()
end

function Pickit.GetGroundItems()
  local t = {}

  for k,v in pairs(Infinity.D3.GetACDList()) do
      if v:GetActorId() ~= -1 and v:GetActorType() == Enums.ActorType.Item and v:GetItemLocation() == -1 then      
        table.insert(t, v)
      end
    end

  Pickit.GroundItems = t
end

function Pickit.TryPickupItems()
  for k,v in pairs(Pickit.GroundItems) do
    if v:GetPosition():GetDistanceFromMe() <= Pickit.Settings.PickupRadius then
      local pickup = false

      if AttributeHelper.IsLegendaryItem(v) then
        if AttributeHelper.IsPrimalLegendaryItem(v) and Pickit.Settings.Legendary.Primal then
          pickup = true
        elseif AttributeHelper.IsAncientLegendaryItem(v) and Pickit.Settings.Legendary.Ancient then
          pickup = true
        elseif Pickit.Settings.Legendary.Normal then
          pickup = true
        end
      end

      if AttributeHelper.IsGemItem(v) and Pickit.Settings.Gem.Enabled then
        pickup = true
      end

      if AttributeHelper.IsCraftMaterial(v) and Pickit.Settings.CraftMaterial.Enabled then
        pickup = true
      end

      if AttributeHelper.IsRiftKey(v) and Pickit.Settings.RiftKey.Enabled then
        pickup = true
      end

      if pickup then
        PickitHelper.PickupItem(RActorHelper.GetRActorByACD(v))
      end
    end
  end
end

function Pickit.OnPulse()
  if Pickit.Running == false then
    return
  end

  Pickit.GetGroundItems()

  if not AttributeHelper.IsInTown(Infinity.D3.GetLocalACD()) then
    Pickit.TryPickupItems()
  end  
end

function Pickit.OnRenderD2D()
end