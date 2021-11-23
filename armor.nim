import std/parsecfg
import std/strutils

type
  Armor* = object
    name*: string
    body*: int
    atype: int
    art*: bool
    protect*: float
    price: float
    condition*: float
    weight*: float
  ArmorSet* = object
    head: Armor
    chest: Armor
    arms: Armor
    legs: Armor
    hands: Armor
    feet: Armor
  Armors* = seq[Armor]

proc get_armor_cfg*(): Armors =
  let armors = loadConfig("armor.cfg")
  for a in armors.sections:
    var armor: Armor
    armor.name = a
    armor.body = armors.getSectionValue(a, "body").parseInt()
    armor.atype = armors.getSectionValue(a, "type").parseInt()
    armor.art = armors.getSectionValue(a, "art").parseBool()
    armor.price = armors.getSectionValue(a, "price").parseFloat()
    armor.protect = armors.getSectionValue(a, "protect").parseFloat()
    armor.condition = armors.getSectionValue(a, "condition").parseFloat()
    armor.weight = armors.getSectionValue(a, "weight").parseFloat()
    result.add(armor)

