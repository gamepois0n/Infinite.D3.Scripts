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

    return self
end
