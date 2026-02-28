local RegionManager = {}
RegionManager.__index = RegionManager

setmetatable(RegionManager, {
    __call = function(cls, ...)
        return cls.new(...)
    end,
})

function RegionManager.new()
    local self = {}
    setmetatable(self, RegionManager)

    self.region_cache = {}
    self.entrance_cache = {}
    self.location_cache = {}
    self.child_only_locations = {}
    self.adult_only_locations = {}

    return self
end

function RegionManager:append(region)
    assert(self.region_cache[region.name] == nil, string.format("%s already exists in region cache.", region.name))
    self.region_cache[region.name] = region
end

function RegionManager:extend(regions)
    for _, region in ipairs(regions) do
        self:append(region)
    end
end

return RegionManager