require 'Items/ProceduralDistributions'

local tgpDistribution = {
  ArmyStorageGuns = {
    items = {
      "BattleRifle", 2,
      "ScarH_Mag", 8,
      "Glock19", 20,
			"Glock19", 10,
      "Glock19_Mag", 20,
			"Glock19_Mag", 10,
			"x6Elcan", 0.5,
    }
  },

  FirearmWeapons = {
    items = {
      "Glock19", 8,
      "Glock19_Mag", 10,
    }
  },

  FirearmWeapons_Mid = {
    items = {
      "Glock19", 8,
      "Glock19_Mag", 10,
			"x6Elcan", 1,
    }
  },
  
  FirearmWeapons_Late = {
    items = {
      "BattleRifle", 1,
      "ScarH_Mag", 4,
      "Glock19", 8,
      "Glock19_Mag", 10,
			"x6Elcan", 1,
    }
  },
  
  LockerArmyBedroom = {
    items = {
      "BattleRifle", 0.001,
      "ScarH_Mag", 0.1,
      "Glock19_Mag", 0.1,
    }
  },

  LockerArmyBedroomHome = {
    items = {
      "Glock19", 0.5,
    }
  },
  
  PawnShopGunsSpecial = {
    items = {
      "BattleRifle", 0.25,
      "ScarH_Mag", 10,
      "Glock19", 8,
      "x6Elcan", 6,
    }
  },

  PlankStashGun = {
    items = {
      "Glock19", 10,
    }
  },

  PoliceDesk = {
    items = {
      "Glock19", 0.1,
    }
  },

  PoliceEvidence = {
    items = {
      "Glock19", 8,
    }
  },

  PoliceOutfit = {
    items = {
      "Glock19", 10,
    }
  },

  PoliceStorageGuns = {
    items = {
      "Glock19", 50,
      "Glock19", 20,
      "Glock19_Mag", 50,
			"Glock19_Mag", 20,
			"Glock19_Mag", 20,
			"Glock19_Mag", 10,
      "x6Elcan", 1,
    }
  },

  PoliceTools = {
    items = {
      "Glock19", 20,
      "Glock19_Mag", 10,
    }
  },

  SecurityDesk = {
    items = {
      "Glock19", 0.1,
      "Glock19_Mag", 0.1,
    }
  },

  SecurityLockers = {
    items = {
      "Glock19", 0.1,
      "Glock19_Mag", 0.1,
    }
  },

  GunStoreAccessories = {
    items = {
      "x6Elcan", 6,
    }
  },

  GunStoreGuns = {
    items = {
      "Glock19", 10,
      "Glock19_Mag", 8,
      "x6Elcan", 4,
    }
  },

  GunStorePistols = {
    items = {
      "Glock19", 50,
      "Glock19_Mag", 20,
    }
  },

  GunStoreRifles = {
    items = {
      "x6Elcan", 4,
    }
  },

  GunStoreMagsAmmo = {
    items = {
      "Glock19_Mag", 50,
      "Glock19_Mag", 20,
    }
  },

  DrugLabGuns = {
    items = {
      "Glock19", 8,
      "Glock19_Mag", 8,
    }
  },

  BedroomDresser = {
    items = {
      "Glock19", 0.5,
    }
  },

  BedroomDresserClassy = {
    items = {
      "Glock19", 0.5,
    }
  },

  BedroomDresserRedneck = {
    items = {
      "Glock19", 0.5,
    }
  },

  BedroomSidetable = {
    items = {
      "Glock19", 0.05,
    }
  },

  BedroomSidetableClassy = {
    items = {
      "Glock19", 0.05,
    }
  },

  BedroomSidetableRedneck = {
    items = {
      "Glock19", 0.05,
    }
  },

  OfficeDeskHome = {
    items = {
      "Glock19", 0.05,
    }
  },

  OfficeDeskHomeClassy = {
    items = {
      "Glock19", 0.05,
    }
  },
  
  DresserGeneric = {
    items = {
      "Glock19", 0.05,
    }
  },

  GarageFirearms = {
    items = {
      "Glock19", 4,
			"x6Elcan", 1,
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
    
