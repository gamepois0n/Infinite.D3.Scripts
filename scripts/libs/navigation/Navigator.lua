Navigator = { }
Navigator.__index = Navigator

setmetatable(Navigator, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Navigator:new(collector)
  local self = setmetatable({}, Navigator)
    
  	self.Collector = collector

  	self.Grid = Infinity.D3.CurrentGrid
	self.Navigator = Infinity.D3.CurrentNavigator

	self.Path = {}
	self.PathCount = 0
	
	self.TargetPos = nil
  return self  
end

function Navigator:SetCellWeight(acd, weight, customradius)
	local cell = self:GetClosestCell(acd:GetPosition())

		if cell ~= nil then
			local radius = math.floor(acd:GetCollisionRadius() / 2.5)

			if customradius ~= nil then
				radius = math.floor(customradius / 2.5)
			end

			local startX = cell:GetCenterX() - (2.5 * radius)
			local startY = cell:GetCenterY() - (2.5 * radius)

			for x = 1, radius * 2, 1 do
				for y = 1, radius * 2, 1 do
					local mapX = self.NavMeshCells[startX + (x * 2.5)]

					if mapX ~= nil then
						local cell = mapX[startY + (y * 2.5)]

						if cell ~= nil then
							cell:SetWeight(weight)
						end
					end
				end
			end
		end
end

function Navigator:GenerateCellWeight()
	for k,acd in pairs(self.Collector.Actors.Monster.All) do
		self:SetCellWeight(acd, 0.7)
	end

	for k,acd in pairs(self.Collector.Actors.GroundEffect.Plagued) do
		self:SetCellWeight(acd, 1.0)
	end

	for k,acd in pairs(self.Collector.Actors.GroundEffect.Desecrator) do
		self:SetCellWeight(acd, 1.0)
	end

	for k,acd in pairs(self.Collector.Actors.GroundEffect.PoisonEnchanted) do
		self:SetCellWeight(acd, 1.0)
	end

	for k,acd in pairs(self.Collector.Actors.GroundEffect.Molten) do
		self:SetCellWeight(acd, 1.0)
	end

	for k,acd in pairs(self.Collector.Actors.GroundEffect.Mortar) do
		self:SetCellWeight(acd, 1.0)
	end

	for k,acd in pairs(self.Collector.Actors.GroundEffect.Frozen) do
		self:SetCellWeight(acd, 1.0, 12)
	end

	for k,acd in pairs(self.Collector.Actors.GroundEffect.Wormwhole) do
		self:SetCellWeight(acd, 1.0)
	end

	for k,acd in pairs(self.Collector.Actors.GroundEffect.Arcane) do
		self:SetCellWeight(acd, 1.0, 18)
	end

	for k,acd in pairs(self.Collector.Actors.GroundEffect.FrozenPulse) do
		self:SetCellWeight(acd, 1.0)
	end

	for k,acd in pairs(self.Collector.Actors.GroundEffect.Orbiter) do
		self:SetCellWeight(acd, 1.0)
	end

	for k,acd in pairs(self.Collector.Actors.GroundEffect.Thunderstorm) do
		self:SetCellWeight(acd, 1.0)
	end

	for k,acd in pairs(self.Collector.Actors.GroundEffect.GrotesqueExplosion) do
		self:SetCellWeight(acd, 1.0, 20)
	end
end

function Navigator:SetTarget(target)
	self.Navigator:Init()

	self.TargetPos = target	
end

function Navigator:GetPath()	
	self.Navigator:PathTo(self.Collector.LocalACD:GetPosition(), self.TargetPos)
	
	self.Path = self.Navigator.Path
	self.PathCount = self.Navigator.PathCount
end

function Navigator:OnPulse()
	--print("Navigator OnPulse")
	
	if self.TargetPos ~= nil then
		self:GetPath()
	end
end