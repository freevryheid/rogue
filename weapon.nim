import std/parsecfg
import std/strutils
import std/random
# import tables

type
  Hit = tuple
    mu: float
    sigma: float
  Wtype = enum
    sword, axe, hammer, bow, crossbow
  Weapon* = object
    name*: string
    hands*: int
    range*: bool
    wtype*: Wtype
    art*: bool
    hit*: Hit
    price: float
  Weapons* = seq[Weapon]

proc get_weapon_cfg*(): Weapons =
  let weapons = loadConfig("weapon.cfg")
  var
    wtype: int
    hitp: float
  for w in weapons.sections:
    var weapon: Weapon
    weapon.name = w
    wtype = weapons.getSectionValue(w, "type").parseInt()
    weapon.wtype = parseEnum[Wtype](wtype)
    weapon.hands = weapons.getSectionValue(w, "hands").parseInt()
    weapon.range = weapons.getSectionValue(w, "range").parseBool()
    weapon.art = weapons.getSectionValue(w, "art").parseBool()
    weapon.price = weapons.getSectionValue(w, "price").parseFloat()
    hitp = weapons.getSectionValue(w, "hit").parseFloat()
    weapon.hit.mu = hitp
    case weapon.wtype
    of sword:
      weapon.hit.sigma = 0.2*hitp
    of axe:
      weapon.hit.sigma = 0.4*hitp
    of hammer:
      weapon.hit.sigma = 0.6*hitp
    of bow:
      weapon.hit.sigma = 0.2*hitp
    of crossbow:
      weapon.hit.sigma = 0.2*hitp
    else: discard
    result.add(weapon)

proc get_hit*(w: Weapon): float =
  result = gauss(w.hit.mu, w.hit.sigma)

