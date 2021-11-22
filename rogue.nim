import std/random
import player
import weapon
import armor



proc main() =
  randomize()
  var
    player: Player
    weapons: Weapons
    armors: Armours

  weapons = get_weapon_cfg()
  armors = get_armor_cfg()

  # player.weapon = weapons[0]
  # echo get_hit(player.weapon)

when isMainModule:
  main()
