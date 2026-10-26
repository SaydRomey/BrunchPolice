# Items, Pickups, Consumables and Status Effects

## Item roles

`ItemDefinition` separates stable identity from presentation and use behavior. Classes include collectible evidence (case-scoped, non-consumable), permanent equipment, stackable consumable, temporary power-up, ammo and key/utility object. World pickups display icon and quantity, emit pickup feedback and remove themselves only after successful inventory admission.

## Power-ups

| World | Power-up | Gameplay purpose |
|---|---|---|
| Grease Canyon | Grease Slide; Extra Bacon | Evasion/trail slow; one-hit absorb |
| Pastry Palace | Syrup Trail; Whipped Cream Shield | Area slowdown; damage absorb |
| Sticky Syrup Swamp | Butter Boots; Honey Comb | Traction protection; bee distraction |
| Kitchen Mayhem | Dish Soap Speed Boost; Shield of Cutlery | Temporary speed; projectile reflection |
| Caffeine Craze | Caffeine Rush; Foam Barrier | Temporary movement/attack haste; one-hit shield |
| Egg Factory Frenzy | Omelet Shield; Egg Timer | Absorb a hit; temporary enemy slow |
| Citrus Cascade | Vitamin Boost; Citrus Blast | Heal; sticky explosive pulp |
| Bakery Bonanza | Oven Mitts; Muffin Shield | Heat protection; projectile absorb |

## Effect library

| Effect tag | Semantics | Stacking baseline |
|---|---|---|
| `slow` | Reduces movement speed | Strongest strength, refresh duration |
| `haste` | Improves movement/attack timing | Refresh duration, capped multiplier |
| `stun` | Suppresses movement/attack | Short duration, diminishing refresh |
| `wrapped` | Holds movement, may allow damage | Single instance with refresh cap |
| `freeze` | Full movement lock | Boss-specific immunity policy |
| `blind` | Reduces aim accuracy or detection | Refresh; visual accessibility alt |
| `burn` | Periodic damage | Refresh with bounded tick count |
| `slippery` | Changes traction/turning | Applied from surfaces or items |
| `shielded` | Absorbs allowed hits | Finite charges; no infinite refills |

## Temporal rules

Status effect records include `effect_id`, potency, duration, time basis, origin attack ID, stacking policy and immunity tags. Permanent pickups are never serialized as active transient statuses. Pause freezes gameplay timers; menu UI timers can continue when permitted. Clearing a state emits an `effect_removed` signal so UI/VFX can reliably disappear.

## Evidence

Evidence IDs are owned by the case system, not stackable inventory quantities. A collectible may trigger an item notification and journal update, but the authoritative discovered flag belongs to `CaseState`. See [Investigation](03-investigation-and-cases.md).
