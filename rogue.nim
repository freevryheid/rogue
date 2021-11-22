import std/random
import player
import weapon
import armor



proc main() =
  randomize()
  var
    player: Player
    weapons: Weapons
    armors: Armors

  weapons = get_weapon_cfg()
  armors = get_armor_cfg()

  player.weapon = weapons[0]
  echo get_hit(player.weapon)
  var
    armor_set: ArmorSet
    armor: Armour
  armor.

when isMainModule:
  main()
