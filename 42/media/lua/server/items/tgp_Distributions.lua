require 'Items/ProceduralDistributions'

local tgpDistribution = {
  ArmyStorageGuns = {
    items = {
      "BattleRifle", 2,
      "ScarH_Mag", 8,
    }
  },
  
  FirearmWeapons_Late = {
    items = {
      "BattleRifle", 1,
      "ScarH_Mag", 4,
    }
  },
  
  LockerArmyBedroom = {
    items = {
      "BattleRifle", 0.001,
      "ScarH_Mag", 0.1,
    }
  },
  
  PawnShopGunsSpecial = {
    items = {
      "BattleRifle", 0.25,
      "ScarH_Mag", 10,
    }
  }
}

-- caching for performance reasons
local ProceduralDistributions_list = ProceduralDistributions.list

local function insertDistribution(distrib)
    -- loop through every given distributions
    for k, v in pairs(distrib) do
        -- cache distributions list
        local distributionCategory = ProceduralDistributions_list[k]

        -- insert distribution
        local items = v.items
        local distributionCategory_items = distributionCategory.items
        if items then
            for i = 1,#items do
                table.insert(distributionCategory_items, items[i])
            end
        end
    end
end

insertDistribution(tgpDistribution)
    
