local Location = require("scripts/logic/base_classes/location")

local SoHLocation = {}
SoHLocation.__index = SoHLocation

setmetatable(
    SoHLocation,
    {
        __index = Location,
        __call = function(cls, ...)
            return cls.new(...)
        end
    }
)

local setting_stage_to_ages = {
    [ShowChecks.CHILD] = {Ages.CHILD},
    [ShowChecks.ADULT] = {Ages.ADULT},
    [ShowChecks.BOTH] = {Ages.CHILD, Ages.ADULT}
}

function SoHLocation.new(name, parent_region, access_rule)
    local self = setmetatable(Location(name, parent_region, access_rule), SoHLocation)
    return self
end

-- override
function SoHLocation:can_reach(state, ages)
    local stored_age = state._soh_age
    local best = ACCESS_NONE
    for _, age in ipairs(ages or setting_stage_to_ages[SETTING_SHOW_CHECKS]) do
        state._soh_age = age
        best = math.max(best, Location.can_reach(self, state))
    end
    state._soh_age = stored_age
    return best
end

return SoHLocation
