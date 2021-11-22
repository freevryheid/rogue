import std/parsecfg
import std/strutils
import std/random
# import tables

type
  Hit = tuple
    mu: float
    sigma: float
  # Wtype = enum
  #   sword, axe, hammer, bow, crossbow
  Weapon* = object
    name*: string
    hands*: int
    range*: bool
    wtype*: int
    art*: bool
    hit*: Hit
    price: float
  Weapons* = seq[Weapon]

proc get_weapon_cfg*(): Weapons =
  let weapons = loadConfig("weapon.cfg")
  var
    # wtype: int
    hitp: float
  for w in weapons.sections:
    var weapon: Weapon
    weapon.name = w
    weapon.wtype = weapons.getSectionValue(w, "type").parseInt()
    weapon.hands = weapons.getSectionValue(w, "hands").parseInt()
    weapon.range = weapons.getSectionValue(w, "range").parseBool()
    weapon.art = weapons.getSectionValue(w, "art").parseBool()
    weapon.price = weapons.getSectionValue(w, "price").parseFloat()
    hitp = weapons.getSectionValue(w, "hit").parseFloat()
    weapon.hit.mu = hitp
    case weapon.wtype
    of 0:
      weapon.hit.sigma = 0.2*hitp
    of 1:
      weapon.hit.sigma = 0.4*hitp
    of 2:
      weapon.hit.sigma = 0.6*hitp
    of 3:
      weapon.hit.sigma = 0.2*hitp
    of 4:
      weapon.hit.sigma = 0.2*hitp
    else: discard
    result.add(weapon)

proc get_hit*(w: Weapon): float =
  result = gauss(w.hit.mu, w.hit.sigma)

