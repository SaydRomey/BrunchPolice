# Weapons Index

# 6. Global Weapon Inventory

## 6.1 Weapon System Concepts

- Weapon attributes:
  - Fire rate.
  - Damage.
  - Ammo capacity.
  - Cooldown.
  - Projectile scene.
- Weapon types:
  - Melee.
  - Ranged.
  - Area-of-effect.
  - Main-hand.
  - Off-hand.
  - Two-handed.
  - Temporary level weapon.
  - Level reward weapon.
- Swappable weapon functionality.
- Projectile spawning through weapon firing.
- Damage can be source-based through `damage_source` dictionaries.
- Status effects may include immobilized, slowed, blinded, stunned, frozen, wrapped, knocked back, pushed, debuffed.

## 6.2 Weapon Effect Categories

| Enemy Class       | Intended Weapon Effect                                               |
| ----------------- | -------------------------------------------------------------------- |
| Small enemy       | Killed by strong/special hit                                         |
| Medium enemy      | Takes damage and may be wrapped/immobilized; killed on critical      |
| Large enemy / mob | Takes damage, partial state effect possible                          |
| Boss              | Immune or limited damage except during defined vulnerability windows |

## 6.3 All Current Weapons By Level

| Level              | Main-hand        | Off-hand                   | Two-handed           | Additional Main-hand                 | Additional Off-hand                 | Additional Two-handed                     | Temporary Weapon   | Reward Weapon        |
| ------------------ | ---------------- | -------------------------- | -------------------- | ------------------------------------ | ----------------------------------- | ----------------------------------------- | ------------------ | -------------------- |
| Grease Canyon      | Bacon Gun        | Extra Bacon / bacon shield | TBD                  | TBD                                  | TBD                                 | TBD                                       | TBD                | TBD                  |
| Pastry Palace      | Croissant Cutter | Whipped Cream Shield       | Baguette Maul        | Cake Cutter Dagger; Frost Edge Knife | Jam Jar Grenade; Butter Spray Can   | Bakery Mixer Staff; Layer Cake Greatsword | Bread Slicer       | Whipped Cream Cannon |
| Sticky Syrup Swamp | Butter Knife     | Sticky Net                 | Syrup Cannon         | Honey Comb Blade; Maple Saber        | Sugar Cube Bomb; Sticky Syrup Globe | Molasses Mallet; Caramel Whip             | Butter Knife       | Syrup Launcher       |
| Kitchen Mayhem     | Chef’s Cleaver   | Hot Lid                    | Rolling Pin Roller   | Paring Knife; Chef’s Skewer          | Pepper Grinder; Hot Sauce Flask     | Stock Pot Shield; Chopping Board Axe      | Dishwasher Sprayer | Rolling Pin          |
| Candy Chaos        | Lollipop Blade   | Sugar Shield               | Candy Floss Launcher | Gum Blade; Candy Cane Dagger         | Chocolate Bomb; Sugar Rush Injector | Marshmallow Launcher; Candy Floss Hammer  | Lollipop Hammer    | Gummy Bear Grenade   |
| Egg Factory Frenzy | Egg Beater       | Yolk Bomb                  | Frying Pan           | Eggshell Knife; Egg Scrambler Blade  | Salt Shaker; Egg Yolk Grenade       | Omelet Spatula; Egg Beater Staff          | Egg Whisk          | Egg Launcher         |
| Citrus Cascade     | Orange Zester    | Juice Squeezer             | Citrus Blaster       | Citrus Saber; Peeler Knife           | Zest Grenade; Lime Shield           | Juicer Staff; Orange Flail                | Zester Shooter     | Citrus Blaster       |
| Bakery Bonanza     | Dough Cutter     | Flour Puff                 | Bread Roller         | Rolling Pin Blade; Dough Hook        | Flour Cloud Bomb; Dough Ball Trap   | Oven Door Shield; Dough Roller Staff      | Dough Roller       | Flour Blaster        |

## 6.4 Global / Special Weapons and Power-Weapon Items

- Bacon Gun.
- Syrup Shooter.
- Syrup Boots.
- Bacon Grease Slide.
- Extra Bacon shield.

## 6.5 Current Weapon Duplicates / Merge Notes

| Item                                     | Issue                                               | Proposed Handling                                                                   |
| ---------------------------------------- | --------------------------------------------------- | ----------------------------------------------------------------------------------- |
| Whipped Cream Shield                     | Appears as off-hand weapon and power-up             | Keep both for now; define one as equipment and one as temporary shield pickup later |
| Butter Knife                             | Appears as main-hand and temporary level weapon     | Mark as `Needs merge`                                                               |
| Citrus Blaster                           | Appears as two-handed and reward weapon             | Mark as `Needs merge`                                                               |
| Dough Cutter / Flour Puff / Bread Roller | Repeated in Bakery list                             | Mark first listing canonical, later duplicates as confirmations                     |
| Rolling Pin / Rolling Pin Roller         | Similar names, different categories                 | Keep both until weapon taxonomy is finalized                                        |
| Bacon Gun                                | Global weapon, level-signature weapon, boss counter | Needs final progression placement                                                   |

---
