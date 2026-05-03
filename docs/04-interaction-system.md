# Interaction System

# 12. Interaction System Inventory

Current interaction system supports:

- Inspecting objects.
- Inspecting NPCs.
- Triggering events.
- Opening doors.
- Activating switches.
- Context-sensitive prompts such as “Press E to talk”.
- Starting a boss fight.
- Picking up temporary weapons.
- Activating checkpoints.
- NPC dialogue integration.
- Dialogue + interaction integration.

Implementation direction:

- Interaction Manager uses `Area2D` style interaction zones.
- Interactions can map to named actions/events.
- NPCs can use interaction triggers to start dialogue.
- Reusable modular triggers should be used for boss fights, weapon pickups, and checkpoints.

---
