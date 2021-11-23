import std/parsecfg
import std/strutils
import std/random

type
  Hit = tuple
    mu: float
    sigma: float
  Weapon* = object
    name*: string
    hands*: int
    range*: bool
    wtype*: int
    art*: bool
    hit*: Hit
    price*: float
    condition*: float
    weight*: float
  Weapons* = seq[Weapon]

proc get_weapon_cfg*(): Weapons =
  let weapons = loadConfig("weapon.cfg")
  var hitp: float
  for w in weapons.sections:
    var weapon: Weapon
    weapon.name = w
    weapon.wtype = weapons.getSectionValue(w, "type").parseInt()
    weapon.hands = weapons.getSectionValue(w, "hands").parseInt()
    weapon.range = weapons.getSectionValue(w, "range").parseBool()
    weapon.art = weapons.getSectionValue(w, "art").parseBool()
    weapon.price = weapons.getSectionValue(w, "price").parseFloat()
    weapon.condition = weapons.getSectionValue(w, "condition").parseFloat()
    weapon.weight = weapons.getSectionValue(w, "weight").parseFloat()
    hitp = weapons.getSectionValue(w, "hit").parseFloat()
    weapon.hit.mu = hitp
    case weapon.wtype
    of 0:  # sword
      weapon.hit.sigma = 0.2*hitp
    of 1:  # axe
      weapon.hit.sigma = 0.4*hitp
    of 2:  # hammer
      weapon.hit.sigma = 0.6*hitp
    of 3:  # bow
      weapon.hit.sigma = 0.2*hitp
    of 4:  # crossbow
      weapon.hit.sigma = 0.4*hitp
    else: discard
    result.add(weapon)

proc get_hit*(w: Weapon): float =
  result = gauss(w.hit.mu, w.hit.sigma)

