Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)
    
    self.Gamble = {}

    self.Gamble.Boots = {Enabled = true, ActorSNO = 377347}
    self.Gamble.ChestArmor = {Enabled = true, ActorSNO = 377345}
    self.Gamble.Helm = {Enabled = true, ActorSNO = 377344}
    self.Gamble.Shoulders = {Enabled = true, ActorSNO = 377348}
    self.Gamble.Gloves = {Enabled = true, ActorSNO = 377346}
    self.Gamble.Phylactery = {Enabled = false, ActorSNO = 472445}
    self.Gamble.Quiver = {Enabled = false, ActorSNO = 377360}
    self.Gamble.Mojo = {Enabled = false, ActorSNO = 377359}
    self.Gamble.Orb = {Enabled = false, ActorSNO = 377358}
    self.Gamble.Shield = {Enabled = false, ActorSNO = 377357}
    self.Gamble.TwoHandedWeapon = {Enabled = false, ActorSNO = 377356}
    self.Gamble.OneHandedWeapon = {Enabled = false, ActorSNO = 377355}
    self.Gamble.Amulet = {Enabled = true, ActorSNO = 377353}
    self.Gamble.Ring = {Enabled = true, ActorSNO = 377352}
    self.Gamble.Bracers = {Enabled = true, ActorSNO = 377351}
    self.Gamble.Pants = {Enabled = true, ActorSNO = 377350}
    self.Gamble.Belt = {Enabled = true, ActorSNO = 377349}

    self.Salvage = {}

    self.Salvage.White = {Enabled = true}
    self.Salvage.Magic = {Enabled = true}
    self.Salvage.Rare = {Enabled = true}
    self.Salvage.LegendaryNormal = {Enabled = false}

    return self
end
