Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)

    self.MapReveal = false

    self.Monsters = {Enabled = true}
    self.Monsters.Normal = {Enabled = false, Minimap = true, MinimapRadius = 2, ColorMinimap = "66999999", CustomRadius = false, CustomRadiusValue = 1, Thickness = 1, Fill = false, ColorOutline = "FF999999", ColorFill = nil}
    
    self.Monsters.Elite = {Enabled = true}
    self.Monsters.Elite.Champion = {Enabled = true, Minimap = true, MinimapRadius = 5, ColorMinimap = "FF0E3C9E", CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = "FF0E3C9E", ColorFill = "785680DB"}
    self.Monsters.Elite.Rare = {Enabled = true, Minimap = true, MinimapRadius = 5, ColorMinimap = "FFD1B31D", CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = "FFD1B31D", ColorFill = "78E5E242"}
    self.Monsters.Elite.Minion = {Enabled = true, Minimap = true, MinimapRadius = 5, ColorMinimap = "FFE5E242", CustomRadius = false, CustomRadiusValue = 1, Thickness = 2, Fill = false, ColorOutline = "FFE5E242", ColorFill = nil}
    self.Monsters.Elite.Unique = {Enabled = true, Minimap = true, MinimapRadius = 5, ColorMinimap = "FF822051", CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = "FF822051", ColorFill = "78C44A87"}


    self.Monsters.Boss = {Enabled = true, Minimap = true, MinimapRadius = 5, ColorMinimap = "FF7E5250", CustomRadius = false, CustomRadiusValue = 1, Thickness = 1, Fill = false, ColorOutline = "FF7E5250", ColorFill = "78C78513"}

    self.Players = {Enabled = false, Minimap = false, MinimapRadius = 5, ColorMinimap = "FF13C72B", CustomRadius = false, CustomRadiusValue = 1, Thickness = 1, Fill = false, ColorOutline = "FF13C72B", ColorFill = nil}
    
    self.Goblins = {Enabled = true, Minimap = true, MinimapRadius = 5, ColorMinimap = "FF0FA3A3", CustomRadius = true, CustomRadiusValue = 3, Thickness = 2, Fill = true, ColorOutline = "FF0FA3A3", ColorFill = "5031EBEB"}

    self.Pylons = {Enabled = true}
    self.Pylons.SpawnMarker = {Enabled = true}
    self.Pylons.Power = {Enabled = true, Text = "Pwr", TextSize = 20, ColorOutline = "FFCA6D10", ColorFill = "78EB9E50", ColorText = "FFFFFFFF"}
    self.Pylons.Conduit = {Enabled = true, Text = "Cdt", TextSize = 20, ColorOutline = "FFCA6D10", ColorFill = "78EB9E50", ColorText = "FFFFFFFF"}
    self.Pylons.Channeling = {Enabled = true, Text = "Chn", TextSize = 20, ColorOutline = "FFCA6D10", ColorFill = "78EB9E50", ColorText = "FFFFFFFF"}
    self.Pylons.Shield = {Enabled = true, Text = "Shd", TextSize = 20, ColorOutline = "FFCA6D10", ColorFill = "78EB9E50", ColorText = "FFFFFFFF"}
    self.Pylons.Speed = {Enabled = true, Text = "Spd", TextSize = 20, ColorOutline = "FFCA6D10", ColorFill = "78EB9E50", ColorText = "FFFFFFFF"}

    self.Shrines = {Enabled = true}
    self.Shrines.Protection = {Enabled = true, Text = "Prt", TextSize = 20, ColorOutline = "FF624A4A", ColorFill = "509F7D7D", ColorText = "FFFFFFFF"}
    self.Shrines.Enlightened = {Enabled = true, Text = "Exp", TextSize = 20, ColorOutline = "FF624A4A", ColorFill = "509F7D7D", ColorText = "FFFFFFFF"}
    self.Shrines.Fortune = {Enabled = true, Text = "Ftn", TextSize = 20, ColorOutline = "FF624A4A", ColorFill = "509F7D7D", ColorText = "FFFFFFFF"}
    self.Shrines.Frenzied = {Enabled = true, Text = "Frz", TextSize = 20, ColorOutline = "FF624A4A", ColorFill = "509F7D7D", ColorText = "FFFFFFFF"}
    self.Shrines.Fleeting = {Enabled = true, Text = "Fle", TextSize = 20, ColorOutline = "FF624A4A", ColorFill = "509F7D7D", ColorText = "FFFFFFFF"}
    self.Shrines.Empowered = {Enabled = true, Text = "Emp", TextSize = 20, ColorOutline = "FF624A4A", ColorFill = "509F7D7D", ColorText = "FFFFFFFF"}
    self.Shrines.Bandit = {Enabled = true, Text = "Bnd", TextSize = 20, ColorOutline = "FF624A4A", ColorFill = "509F7D7D", ColorText = "FFFFFFFF"}


    self.GroundEffects = {Enabled = true}
    self.GroundEffects.Plagued = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = "FF2DB72D", ColorFill = "781B721B"}
    self.GroundEffects.Desecrator = {Enabled = true,CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = "FFE67B41", ColorFill = "78AB5120"}
    self.GroundEffects.PoisonEnchanted = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = "FF2DB72D", ColorFill = "781B721B"}
    self.GroundEffects.Molten = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = "FFF6A121", ColorFill = "78A06307"}
    self.GroundEffects.Mortar = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = "FFB99D72", ColorFill = "78836943"}    
    self.GroundEffects.Frozen = {Enabled = true, CustomRadius = true, CustomRadiusValue = 14, Thickness = 3, Fill = false, ColorOutline = "FF3F7FBF", ColorFill = nil}
    self.GroundEffects.FrozenPulse = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = "FF3F7FBF", ColorFill = "783F7FBF"}
    self.GroundEffects.Orbiter = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = "FF15AC6D", ColorFill = "7835E89D"}
    self.GroundEffects.Thunderstorm = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = "FF15AC6D", ColorFill = "7835E89D"}
    self.GroundEffects.Arcane = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 2, Fill = false, ColorOutline = "FF7F3FBF", ColorFill = "78AD7BDF"}
    self.GroundEffects.Wormwhole = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 2, Fill = false, ColorOutline = "787F3FBF", ColorFill = nil}
    self.GroundEffects.OccuCircle = {Enabled = true, CustomRadius = false, CustomRadiusValue = 1, Thickness = 3, Fill = false, ColorOutline = "FFD743DF", ColorFill = "78821687"}

    self.Items = {Enabled = true}
    self.Items.RiftProgressOrb = {Enabled = true}
    self.Items.Legendary = {Enabled = true}
    self.Items.Legendary.Normal = {Enabled = true, CustomRadius = true, CustomRadiusValue = 1.5, Thickness = 1, Fill = false, ColorOutline = "FF753913", ColorFill = nil}
    self.Items.Legendary.Ancient = {Enabled = true, CustomRadius = true, CustomRadiusValue = 1.5, Thickness = 3, Fill = false, ColorOutline = "FF753913", ColorFill = nil}
    self.Items.Legendary.Primal = {Enabled = true, CustomRadius = true, CustomRadiusValue = 1.5, Thickness = 3, Fill = false, ColorOutline = "FF753913", ColorFill = "78B85213"}
    
    self.Affixes = {Enabled = true}
    self.Affixes.Molten = {Enabled = true, Text = "Mol", Size = 16, LabelColor = "FFE1770E", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Arcane = {Enabled = true, Text = "Arc", Size = 16, LabelColor = "FF8B218B", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Avenger = {Enabled = true, Text = "Ave", Size = 16, LabelColor = "FF878787", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Mortar = {Enabled = true, Text = "Mor", Size = 16, LabelColor = "FFB87946", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Desecrator = {Enabled = true, Text = "Des", Size = 16, LabelColor = "FFE1770E", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Electrified = {Enabled = true, Text = "Ele", Size = 16, LabelColor = "FF46B8B3", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.ExtraHealth = {Enabled = true, Text = "EHP", Size = 16, LabelColor = "FF878787", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Fast = {Enabled = true, Text = "Fst", Size = 16, LabelColor = "FF878787", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Frozen = {Enabled = true, Text = "Frz", Size = 16, LabelColor = "FF379AF0", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Healthlink = {Enabled = true, Text = "HPL", Size = 16, LabelColor = "FF878787", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Illusionist = {Enabled = true, Text = "Ill", Size = 16, LabelColor = "FF878787", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Jailer = {Enabled = true, Text = "Jlr", Size = 16, LabelColor = "FF878787", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Knockback = {Enabled = true, Text = "Knb", Size = 16, LabelColor = "FF878787", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.MissileDampening = {Enabled = true, Text = "Mis", Size = 16, LabelColor = "FF878787", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Nightmarish = {Enabled = true, Text = "Nmr", Size = 16, LabelColor = "FF878787", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Plagued = {Enabled = true, Text = "Plg", Size = 16, LabelColor = "FF17AC15", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.ReflectsDamage = {Enabled = true, Text = "Ref", Size = 16, LabelColor = "FFAC4215", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Shielding = {Enabled = true, Text = "Shd", Size = 16, LabelColor = "FF878787", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Teleporter = {Enabled = true, Text = "Tel", Size = 16, LabelColor = "FF878787", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Thunderstorm = {Enabled = true, Text = "Thu", Size = 16, LabelColor = "FF46B8B3", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Vortex = {Enabled = true, Text = "Vtx", Size = 16, LabelColor = "FF878787", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Waller = {Enabled = true, Text = "Wal", Size = 16, LabelColor = "FF878787", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Firechains = {Enabled = true, Text = "Fch", Size = 16, LabelColor = "FFE1770E", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Orbiter = {Enabled = true, Text = "Orb", Size = 16, LabelColor = "FF46B8B3", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.FrozenPulse = {Enabled = true, Text = "Frp", Size = 16, LabelColor = "FF379AF0", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.PoisonEnchanted = {Enabled = true, Text = "Psn", Size = 16, LabelColor = "FF17AC15", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Juggernaut = {Enabled = true, Text = "Jug", Size = 16, LabelColor = "FFD10E0E", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}
    self.Affixes.Wormhole = {Enabled = true, Text = "Who", Size = 16, LabelColor = "FF878787", LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2}

    return self
end
