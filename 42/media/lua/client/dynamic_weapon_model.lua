require "TimedActions/ISInsertMagazine"
require "TimedActions/ISEjectMagazine"
require "TimedActions/ISUpgradeWeapon"
require "TimedActions/ISRemoveWeaponUpgrade"

local tgpWeaponDisplayNames = {
  ["Scar-H Battle Rifle"] = true
}

local function isWeaponFirearm(item)
	return item and item.IsWeapon and item:IsWeapon() and item.isRanged and item:isRanged()
end

local function parseSpriteState(sprite)
  sprite = sprite or ""
  local hasNoMagSuffix = sprite:find("_NoMag", 1, true) ~= nil
  local hasSightDownSuffix = sprite:find("_SightDown", 1, true) ~= nil
  local base = sprite:gsub("_NoMag", ""):gsub("_SightDown", "")
  return base, hasNoMagSuffix, hasSightDownSuffix
end

local function setSpriteState(weapon, noMag, hasScope)
  local base = select(1, parseSpriteState(weapon:getWeaponSprite()))
  local newSprite = base .. (noMag and "_NoMag" or "") .. (hasScope and "_SightDown" or "")
  weapon:setWeaponSprite(newSprite)
end

local function handleAttachScope(args)
  local weapon = args.weapon
  local weaponPart = args.weaponPart

  -- Prevent behavior for vanilla guns
  local currentWeaponDisplayName = weapon:getDisplayName()
  if not tgpWeaponDisplayNames[currentWeaponDisplayName] then
    return
  end
  
  local base, hasNoMagSuffix, _ = parseSpriteState(weapon:getWeaponSprite())
  local isScope = weaponPart:getPartType() == 'Scope'

  if isScope then
    setSpriteState(weapon, hasNoMagSuffix, isScope)
  end
end

-- TODO: Investigate model not refreshed after detaching part even in vanilla guns
local function handleDetachScope(args)
  local char = args.char
  local weapon = args.weapon
  local detachedPartType = args.detachedPartType

  -- Prevent behavior for vanilla guns
  local currentWeaponDisplayName = weapon:getDisplayName()
  if not tgpWeaponDisplayNames[currentWeaponDisplayName] then
    return
  end

  local base, hasNoMagSuffix, _ = parseSpriteState(weapon:getWeaponSprite())
  local isScope = detachedPartType == "Scope"

  if isScope then
    setSpriteState(weapon, hasNoMagSuffix, false)
  end
end

local function handleMagazineModel(args)
  local char = args.char
  local weapon = args.weapon

  -- Check Guard
  if not char then return end

  -- Check Guard
  local weaponIsFirearm = isWeaponFirearm(weapon)
  if not weaponIsFirearm then
    return
  end

  -- Prevent behavior for vanilla guns
  local currentWeaponDisplayName = weapon:getDisplayName()
  if not tgpWeaponDisplayNames[currentWeaponDisplayName] then
    return
  end

  local base, _, hasSightDownSuffix = parseSpriteState(weapon:getWeaponSprite())
  local noMag = not weapon:isContainsClip()
  setSpriteState(weapon, noMag, hasSightDownSuffix)
end

local function patchAction(tbl, fnName, weaponField, action)
  -- Check Guard
  if not tbl or tbl["__patched_" .. fnName] then
    return
  end

  -- Check Guard
  local original = tbl[fnName]
  if type(original) ~= "function" then
    return 
  end

  tbl["__patched_" .. fnName] = true

  -- patch vanilla lua function 
  tbl[fnName] =
  function(self, ...)
    local res = original(self, ...)
    action {
      char = self.character,
      weapon = self[weaponField] or self.weapon or self.gun,
      weaponPart = self.part,
      detachedPartType = self.partType
    }
    return res
  end
end

local function applyPatches()
  patchAction(ISInsertMagazine, "complete", "gun", handleMagazineModel)
  patchAction(ISEjectMagazine, "complete", "gun", handleMagazineModel)
  patchAction(ISUpgradeWeapon, "complete", "weapon", handleAttachScope)
  patchAction(ISRemoveWeaponUpgrade, "complete", "weapon", handleDetachScope)
end

Events.OnGameBoot.Add(applyPatches)
Events.OnGameStart.Add(applyPatches)
applyPatches()