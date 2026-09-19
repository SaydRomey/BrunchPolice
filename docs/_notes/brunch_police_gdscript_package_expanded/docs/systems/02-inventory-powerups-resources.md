# Inventory, Power-Ups, and Resources

## Inventory

`Inventory.gd` stores item records by name and supports adding, removing, using, and equipping items.

Equipment slots:

- `main_hand`
- `off_hand`
- `two_hand`

Equipping a two-handed item automatically clears main-hand and off-hand equipment. Equipping a main-hand or off-hand item clears the two-handed slot.

## Power-Ups

`PowerUpManager.gd` tracks active timed power-ups. Each power-up can have an apply callback and an expire callback.

## Game Resources

`GameResourceManager.gd` tracks global resources like coins, keys, magic, stamina, and collectibles. It supports limits and emits a signal whenever a resource changes.

## Stamina

`Stamina.gd` is a reusable regenerating resource component for player actions like jumping, dashing, blocking, or charged attacks.

## Converted Scripts

| Script | Purpose |
|---|---|
| `godot/autoloads/Inventory.gd` | Inventory and equipment slots |
| `godot/autoloads/PowerUpManager.gd` | Timed power-up effects |
| `godot/autoloads/GameResourceManager.gd` | Coins, keys, magic, stamina, and limits |
| `godot/components/Stamina.gd` | Regenerating stamina component |
| `godot/pickups/Coin.gd` | Collectible coin example |
| `godot/pickups/WeaponPickup.gd` | Weapon pickup example |
