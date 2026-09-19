# Level Reward Weapons

These weapons are intended as boss or level rewards that can be placed in inventory and reused outside their original level.

| Level | Reward Weapon | Core Mechanic | Enemy Effect |
|---|---|---|---|
| Pastry Palace | Whipped Cream Cannon | Fires cream blobs | Slows movement and covers enemy visuals |
| Sticky Syrup Swamp | Syrup Launcher | Fires syrup globs that create pools | Immobilizes and damages over time |
| Kitchen Mayhem | Rolling Pin | Quick swing or charged spin | Light damage or knockback |
| Egg Factory Frenzy | Egg Launcher | Fires exploding eggs | Direct damage plus splash damage |
| Citrus Cascade | Citrus Blaster | Rapid acidic juice stream | Pushback and minor damage over time |
| Candy Chaos | Gummy Bear Grenade | Spawns sticky gummy bears | Slows, latches, then explodes |
| Bakery Bonanza | Flour Blaster | Shoots flour puffs | Blinds and briefly stuns |

## GDScript Coverage

Projectile-style reward weapons can be implemented by extending `Weapon.gd` and passing different `effect_data` into `Projectile.gd`.

Provided weapon scripts:

- `WhippedCreamCannon.gd`
- `SyrupLauncher.gd`
- `RollingPin.gd`
- `EggLauncher.gd`
- `CitrusBlaster.gd`
- `GummyBearGrenade.gd`
- `FlourBlaster.gd`
