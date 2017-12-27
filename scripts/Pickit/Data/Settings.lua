Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)
    
    self.PickupRadius = 15

    self.Normal = {White = true}
    self.Legendary = {Normal = true, Ancient = true, Primal = true}
    
    self.Gem = {Enabled = true}

    self.CraftMaterial = {Enabled = true}

    self.RiftKey = {Enabled = true}
    return self
end
