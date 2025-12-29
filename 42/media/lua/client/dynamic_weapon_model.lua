require "TimedActions/ISInsertMagazine"
require "TimedActions/ISEjectMagazine"

local tgpWeaponDisplayNames = {
  ["Scar-H Battle Rifle"] = true
}

local function isWeaponFirearm(item)
	return item and item.IsWeapon and item:IsWeapon() and item.isRanged and item:isRanged()
end

local function refreshWeaponModel(char, weapon)
  if not char then return end

  local weaponIsFirearm = isWeaponFirearm(weapon)
  if not weaponIsFirearm then
    return
  end

  -- Prevent behavior for vanilla guns
  local currentWeaponDisplayName = weapon:getDisplayName()
  if not tgpWeaponDisplayNames[currentWeaponDisplayName] then
    return
  end
  
  local weaponSprite = weapon:getWeaponSprite()  
  local hasMag = weapon:isContainsClip()

  if hasMag then
    local newSprite = string.gsub(weaponSprite, "_NoMag", "")
    weapon:setWeaponSprite(newSprite)
    return
  end

  weapon:setWeaponSprite(weaponSprite .. "_NoMag")
end

local function patchAction(tbl, fnName, weaponField)
  if not tbl or tbl["__patched_" .. fnName] then
    return
  end

  local original = tbl[fnName]
  if type(original) ~= "function" then
    return 
  end

  tbl["__patched_" .. fnName] = true
  tbl[fnName] = function(self, ...)
    local res = original(self, ...)
		local weapon = self[weaponField] or self.weapon or self.gun
    refreshWeaponModel(self.character, weapon)
    return res
  end
end

local function applyPatches()
  patchAction(ISInsertMagazine, "perform", "gun")
  patchAction(ISEjectMagazine, "perform", "gun")
end

Events.OnGameBoot.Add(applyPatches)
Events.OnGameStart.Add(applyPatches)
applyPatches()