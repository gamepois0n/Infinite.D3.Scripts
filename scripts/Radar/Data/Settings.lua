Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)

    self.Monsters = {Enabled = true}
    self.Monsters.Normal = {Enabled = false, CustomRadius = false, CustomRadiusValue = 1, Thickness = 1, Fill = false, ColorOutline = {A = 0xFF, R = 0x99, G = 0x99, B = 0x99}, ColorFill = nil}
    
    self.Monsters.Elite = {Enabled = true}
    self.Monsters.Elite.Champion = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0x0E, G = 0x3C, B = 0x9E}, ColorFill = {A = 0x78, R = 0x56, G = 0x80, B = 0xDB}}
    self.Monsters.Elite.Rare = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0xD1, G = 0xB3, B = 0x1D}, ColorFill = {A = 0x78, R = 0xE5, G = 0xE2, B = 0x42}}
    self.Monsters.Elite.Minion = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 2, Fill = false, ColorOutline = {A = 0xFF, R = 0xE5, G = 0xE2, B = 0x42}, ColorFill = nil}
    self.Monsters.Elite.Unique = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0x82, G = 0x20, B = 0x51}, ColorFill = {A = 0x78, R = 0xC4, G = 0x4A, B = 0x87}}


    self.Monsters.Boss = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 1, Fill = false, ColorOutline = {A = 0xFF, R = 0x7E, G = 0x52, B = 0x50}, ColorFill = {A = 0x78, R = 0xC7, G = 0x85, B = 0x13}}

    self.Players = {Enabled = false, CustomRadius = false, CustomRadiusValue = 1, Thickness = 1, Fill = false, ColorOutline = {A = 0xFF, R = 0x13, G = 0xC7, B = 0x2B}, ColorFill = nil}

    self.Gizmos = {Enabled = false, CustomRadius = false, CustomRadiusValue = 1, Thickness = 1, Fill = true, ColorOutline = {A = 0x78, R = 0xFF, G = 0xFF, B = 0xFF}, ColorFill = nil}

    self.Goblins = {Enabled = true, CustomRadius = true, CustomRadiusValue = 3, Thickness = 2, Fill = true, ColorOutline = {A = 0xFF, R = 0x0F, G = 0xA3, B = 0xA3}, ColorFill = {A = 0x50, R = 0x31, G = 0xEB, B = 0xEB}}

    self.Pylons = {Enabled = true}
    self.Pylons.Power = {Enabled = true, Text = "Pwr", TextSize = 20, ColorOutline = {A = 0xFF, R = 0xCA, G = 0x6D, B = 0x10}, ColorFill = {A = 0x78, R = 0xEB, G = 0x9E, B = 0x50}, ColorText = {A = 0xFF, R = 0xFF, G = 0xFF, B = 0xFF}}
    self.Pylons.Conduit = {Enabled = true, Text = "Cdt", TextSize = 20, ColorOutline = {A = 0xFF, R = 0xCA, G = 0x6D, B = 0x10}, ColorFill = {A = 0x78, R = 0xEB, G = 0x9E, B = 0x50}, ColorText = {A = 0xFF, R = 0xFF, G = 0xFF, B = 0xFF}}
    self.Pylons.Channeling = {Enabled = true, Text = "Chn", TextSize = 20, ColorOutline = {A = 0xFF, R = 0xCA, G = 0x6D, B = 0x10}, ColorFill = {A = 0x78, R = 0xEB, G = 0x9E, B = 0x50}, ColorText = {A = 0xFF, R = 0xFF, G = 0xFF, B = 0xFF}}
    self.Pylons.Shield = {Enabled = true, Text = "Shd", TextSize = 20, ColorOutline = {A = 0xFF, R = 0xCA, G = 0x6D, B = 0x10}, ColorFill = {A = 0x78, R = 0xEB, G = 0x9E, B = 0x50}, ColorText = {A = 0xFF, R = 0xFF, G = 0xFF, B = 0xFF}}
    self.Pylons.Speed = {Enabled = true, Text = "Spd", TextSize = 20, ColorOutline = {A = 0xFF, R = 0xCA, G = 0x6D, B = 0x10}, ColorFill = {A = 0x78, R = 0xEB, G = 0x9E, B = 0x50}, ColorText = {A = 0xFF, R = 0xFF, G = 0xFF, B = 0xFF}}

    self.Shrines = {Enabled = true}
    self.Shrines.Protection = {Enabled = true, Text = "Prt", TextSize = 20, ColorOutline = {A = 0xFF, R = 0x62, G = 0x4A, B = 0x4A}, ColorFill = {A = 0x50, R = 0x9F, G = 0x7D, B = 0x7D}, ColorText = {A = 0xFF, R = 0xFF, G = 0xFF, B = 0xFF}}
    self.Shrines.Enlightened = {Enabled = true, Text = "Exp", TextSize = 20, ColorOutline = {A = 0xFF, R = 0x62, G = 0x4A, B = 0x4A}, ColorFill = {A = 0x50, R = 0x9F, G = 0x7D, B = 0x7D}, ColorText = {A = 0xFF, R = 0xFF, G = 0xFF, B = 0xFF}}
    self.Shrines.Fortune = {Enabled = true, Text = "Ftn", TextSize = 20, ColorOutline = {A = 0xFF, R = 0x62, G = 0x4A, B = 0x4A}, ColorFill = {A = 0x50, R = 0x9F, G = 0x7D, B = 0x7D}, ColorText = {A = 0xFF, R = 0xFF, G = 0xFF, B = 0xFF}}
    self.Shrines.Frenzied = {Enabled = true, Text = "Frz", TextSize = 20, ColorOutline = {A = 0xFF, R = 0x62, G = 0x4A, B = 0x4A}, ColorFill = {A = 0x50, R = 0x9F, G = 0x7D, B = 0x7D}, ColorText = {A = 0xFF, R = 0xFF, G = 0xFF, B = 0xFF}}
    self.Shrines.Fleeting = {Enabled = true, Text = "Fle", TextSize = 20, ColorOutline = {A = 0xFF, R = 0x62, G = 0x4A, B = 0x4A}, ColorFill = {A = 0x50, R = 0x9F, G = 0x7D, B = 0x7D}, ColorText = {A = 0xFF, R = 0xFF, G = 0xFF, B = 0xFF}}
    self.Shrines.Empowered = {Enabled = true, Text = "Emp", TextSize = 20, ColorOutline = {A = 0xFF, R = 0x62, G = 0x4A, B = 0x4A}, ColorFill = {A = 0x50, R = 0x9F, G = 0x7D, B = 0x7D}, ColorText = {A = 0xFF, R = 0xFF, G = 0xFF, B = 0xFF}}
    self.Shrines.Bandit = {Enabled = true, Text = "Bnd", TextSize = 20, ColorOutline = {A = 0xFF, R = 0x62, G = 0x4A, B = 0x4A}, ColorFill = {A = 0x50, R = 0x9F, G = 0x7D, B = 0x7D}, ColorText = {A = 0xFF, R = 0xFF, G = 0xFF, B = 0xFF}}


    self.GroundEffects = {Enabled = true}
    self.GroundEffects.Plagued = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0x2D, G = 0xB7, B = 0x2D}, ColorFill = {A = 0x78, R = 0x1B, G = 0x72, B = 0x1B}}
    self.GroundEffects.Desecrator = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0xE6, G = 0x7B, B = 0x41}, ColorFill = {A = 0x78, R = 0xAB, G = 0x51, B = 0x20}}
    self.GroundEffects.PoisonEnchanted = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0x2D, G = 0xB7, B = 0x2D}, ColorFill = {A = 0x78, R = 0x1B, G = 0x72, B = 0x1B}}
    self.GroundEffects.Molten = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0xF6, G = 0xA1, B = 0x21}, ColorFill = {A = 0x78, R = 0xA0, G = 0x63, B = 0x07}}
    self.GroundEffects.Mortar = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0xB9, G = 0x9D, B = 0x72}, ColorFill = {A = 0x78, R = 0x83, G = 0x69, B = 0x43}}    
    self.GroundEffects.Frozen = {Enabled = true, CustomRadius = true, CustomRadiusValue = 14, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0x3F, G = 0x7F, B = 0xBF}, ColorFill = nil}
    self.GroundEffects.FrozenPulse = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0x3F, G = 0x7F, B = 0xBF}, ColorFill = {A = 0x78, R = 0x3F, G = 0x7F, B = 0xBF}}
    self.GroundEffects.Orbiter = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0x15, G = 0xAC, B = 0x6D}, ColorFill = {A = 0x78, R = 0x35, G = 0xE8, B = 0x9D}}
    self.GroundEffects.Thunderstorm = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0x15, G = 0xAC, B = 0x6D}, ColorFill = {A = 0x78, R = 0x35, G = 0xE8, B = 0x9D}}
    self.GroundEffects.Arcane = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 2, Fill = false, ColorOutline = {A = 0xFF, R = 0x7F, G = 0x3F, B = 0xBF}, ColorFill = {A = 0x78, R = 0xAD, G = 0x7B, B = 0xDF}}
    self.GroundEffects.Wormwhole = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 2, Fill = false, ColorOutline = {A = 0x78, R = 0x7F, G = 0x3F, B = 0xBF}, ColorFill = nil}
    self.GroundEffects.OccuCircle = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0xD7, G = 0x43, B = 0xDF}, ColorFill = {A = 0x78, R = 0x82, G = 0x16, B = 0x87}}

    self.Items = {Enabled = true}
    self.Items.Legendary = {Enabled = true}
    self.Items.Legendary.Normal = {Enabled = true, CustomRadius = true, CustomRadiusValue = 1.5, Thickness = 1, Fill = false, ColorOutline = {A = 0xFF, R = 0x75, G = 0x39, B = 0x13}, ColorFill = nil}
    self.Items.Legendary.Ancient = {Enabled = true, CustomRadius = true, CustomRadiusValue = 1.5, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0x75, G = 0x39, B = 0x13}, ColorFill = nil}
    self.Items.Legendary.Primal = {Enabled = true, CustomRadius = true, CustomRadiusValue = 1.5, Thickness = 3, Fill = false, ColorOutline = {A = 0xFF, R = 0x75, G = 0x39, B = 0x13}, ColorFill = {A = 0x78, R = 0xB8, G = 0x52, B = 0x13}}
    
    return self
end
