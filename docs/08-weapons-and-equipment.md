# Weapons and Equipment

## Slots and actions

The player has `main_hand`, `off_hand` and `two_hand` slots. Equipping a two-handed weapon occupies both hands; unequipping restores legal inventory state, not an untracked hidden item. Each weapon may provide **quick**, **charged**, and **special** actions; unsupported actions are visibly disabled. Shields use guard/parry actions; throwables and utility items have explicit uses and stack counts.

## Definition structure

`WeaponDefinition` contains: `weapon_id`, name/localization key, category, allowed slots, icon/sprite, action definitions, equip restrictions, optional ammo type, VFX profile and tags. `AttackDefinition` includes attack kind (melee/projectile/field/guard), damage, range, active duration, cooldown, charge time, input mode, projectile/field resource, status payload, knockback and feedback. Numeric fields are Inspector-tunable.

## Reusable archetypes

| Archetype | Base implementation | Examples |
|---|---|---|
| Light melee | Short-lived active hitbox, lunge optional | Brunch Fork, Croissant Cutter, Espresso Stirrer |
| Heavy melee | Windup, wide cleave or ground shockwave | Baguette Maul, Tamper Hammer, Frying Pan |
| Ranged launcher | Projectile scene + lifetime, hit policy | Bacon Gun, Whipped Cream Cannon, Egg Launcher, Portafilter Blaster |
| Shield | Guard arc, durability, block event | Extra Bacon Shield, Hot Lid, Coffee Filter Shield |
| Throwable | Arc or target landing → impact/field | Jam Jar Grenade, Yolk Bomb, Bean Bomb |
| Utility/trap | Persistent area or temporary actor modifier | Sticky Net, Pepper Grinder, Grease Slide |

## Core weapons and world loadouts

**Global:** Brunch Fork is the baseline. Bacon Gun is a signature control launcher; a campaign availability decision is tracked as a balancing/content task, not baked into behavior.

| World | Main-hand | Off-hand | Two-handed | World-special / reward |
|---|---|---|---|---|
| Grease Canyon | Bacon Gun / Brunch Fork | Extra Bacon | Optional heavy unlock | Grease Slide / bacon control |
| Pastry Palace | Croissant Cutter | Whipped Cream Shield | Baguette Maul | Bread Slicer / Whipped Cream Cannon |
| Sticky Syrup Swamp | Butter Knife | Sticky Net | Syrup Cannon | Butter Knife pickup / Syrup Launcher |
| Kitchen Mayhem | Chef's Cleaver | Hot Lid | Rolling Pin Roller | Dishwasher Sprayer / Rolling Pin |
| Caffeine Craze | Espresso Stirrer | Coffee Filter Shield | Portafilter Blaster | Tamper Hammer / Bean Bomb |
| Egg Factory Frenzy | Egg Beater | Yolk Bomb | Frying Pan | Egg Whisk / Egg Launcher |
| Citrus Cascade | Orange Zester | Juice Squeezer | Citrus Blaster | Zester Shooter / Citrus Blaster reward variant |
| Bakery Bonanza | Dough Cutter | Flour Puff | Bread Roller | Dough Roller / Flour Blaster |

Additional variants and visual hooks are in the [weapon roster](reference/weapon-roster.md).

## Rules

- `weapon_id` is stable; display name and image can be changed without breaking saves.
- Runtime projectiles derive ownership/faction from their spawner and never from a sprite filename.
- Charge timers, ammo, cooldowns and item counts cannot become negative.
- Attack animation effects are events; they do not independently apply damage unless explicitly defined as hitbox activators.
- Every weapon receives one interactive test and one combat contract test against an ordinary enemy, an immune enemy and an armored boss.
