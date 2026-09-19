
# Roaming NPC

Behavior:
```
IDLE
  WaitTimer ends
	↓
MOVING
  Player interacts
	↓
TALKING
  TalkTimer ends
	↓
MOVING, if the NPC previously had a destination

or

IDLE, if the NPC was previously waiting
```
