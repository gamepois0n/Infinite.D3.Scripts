Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)
    
    self.LastCombatScript = ""
    self.Defend = {Enabled = true}
    self.Buff = {Enabled = true}
    self.Attack = {Enabled = true}

    self.ParagonPoints = {{Mainstat = "-1", Vitality = "0", MovementSpeed = "50", MaxResource = "0", Hotkey = -1}, {Mainstat = "0", Vitality = "-1", MovementSpeed = "0", MaxResource = "0", Hotkey = -1}}    
    return self
end
