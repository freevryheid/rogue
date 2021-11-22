import std/parsecfg
import std/strutils

type
  Body = enum
    head, chest, arms, legs, hands, feet
  Atype = enum
    light, medium, heavy
  Armor* = object
    name*: string
    body*: Body
    atype: Atype
    art*: bool
    protect*: float
    price: float
  ArmorSet* = object
    head: Armor
    chest: Armor
    arms: Armor
    legs: Armor
    hands: Armor
    feet: Armor
  Armors = seq[Armor]

proc get_armor_cfg*(): Armors =
  let armors = loadConfig("armor.cfg")
  var
    body, atype: int
  for a in armors.sections:
    var
      armor: Armor
    armor.name = a
    body = armors.getSectionValue(a, "body").parseInt()
    armor.body = parseEnum[Body](body)
    atype = armors.getSectionValue(a, "type").parseInt()
    armor.atype = parseEnum[Atype](atype)
    armor.art = armors.getSectionValue(a, "art").parseBool()
    armor.price = armors.getSectionValue(a, "price").parseFloat()
    armor.protect = armors.getSectionValue(a, "protect").parseFloat()
    result.add(armor)



