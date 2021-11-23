import weapon
import armor

type
  Soldier* = object
    weapon*: Weapon
    armor*: ArmorSet
    health*: float
    fatigue*: float
    hunger*: float
    thirst*: float
    morale*: float
    xp*: float



