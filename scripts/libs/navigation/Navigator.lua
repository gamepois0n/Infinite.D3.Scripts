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

  	self.NavMesh = Infinity.D3.NavMesh()
	self.NavMeshCells = {}

  return self  
end

function Navigator:GetClosestCell(pos)
	if pos == nil then
		return nil
	end

	--local x = math.floor(pos.X / 2.5) * 2.5

	for kx,kv in pairs(self.NavMeshCells) do
		if kx < pos.X and kx + 2.5 > pos.X then
			for ky,cell in pairs(kv) do
				if ky < pos.Y and ky + 2.5 > pos.Y then
					return cell
				end
			end
		end
	end	

	return nil
end

function Navigator:GenerateCellWeight()
	for k,acd in pairs(self.Collector.Actors.All) do
		local cell = self:GetClosestCell(acd:GetPosition())

		if cell ~= nil then
			local radius = math.floor(acd:GetCollisionRadius() / 2.5)
			local startX = cell:GetCenterX() - (2.5 * radius)
			local startY = cell:GetCenterY() - (2.5 * radius)

			for x = 1, radius * 2, 1 do
				for y = 1, radius * 2, 1 do
					local mapX = self.NavMeshCells[startX + (x * 2.5)]

					if mapX ~= nil then
						local cell = mapX[startY + (y * 2.5)]

						if cell ~= nil then
							cell:SetWeight(1.0)
						end
					end
				end
			end
		end
	end
end

function Navigator:OnPulse()
	--print("Navigator OnPulse")
	self.NavMeshCells = self.NavMesh:GetNavMeshCells()

	self:GenerateCellWeight()
end