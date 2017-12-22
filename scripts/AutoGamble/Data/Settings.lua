Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)
    
    self.Boots = {Enabled = true, ActorSNO = 377347}
    self.ChestArmor = {Enabled = true, ActorSNO = 377345}
    self.Helm = {Enabled = true, ActorSNO = 377344}
    self.Shoulders = {Enabled = true, ActorSNO = 377348}
    self.Gloves = {Enabled = true, ActorSNO = 377346}
    self.Phylactery = {Enabled = false, ActorSNO = 472445}
    self.Quiver = {Enabled = false, ActorSNO = 377360}
    self.Mojo = {Enabled = false, ActorSNO = 377359}
    self.Orb = {Enabled = false, ActorSNO = 377358}
    self.Shield = {Enabled = false, ActorSNO = 377357}
    self.TwoHandedWeapon = {Enabled = false, ActorSNO = 377356}
    self.OneHandedWeapon = {Enabled = false, ActorSNO = 377355}
    self.Amulet = {Enabled = true, ActorSNO = 377353}
    self.Ring = {Enabled = true, ActorSNO = 377352}
    self.Bracers = {Enabled = true, ActorSNO = 377351}
    self.Pants = {Enabled = true, ActorSNO = 377350}
    self.Belt = {Enabled = true, ActorSNO = 377349}

    return self
end
