import std/random
import player
import weapon
import armor

proc main() =
  randomize()
  var
    weapons: Weapons
    armors: Armors

  weapons = get_weapon_cfg()
  armors = get_armor_cfg()

when isMainModule:
  main()
