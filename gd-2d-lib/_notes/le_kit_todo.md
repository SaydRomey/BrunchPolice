
func _get_debug_state_text() -> String:

```gdscript
enum ElementState {
    IDLE,
    WARNING,
    ACTIVE,
    COOLDOWN,
    DISABLED,
    BROKEN
}
```

Element	Relevant states
Switch	OFF, ON, DISABLED
Door	CLOSED, OPENING, OPEN, CLOSING, LOCKED
Collapsing platform	IDLE, WARNING, COLLAPSED, RESETTING
Steam vent	IDLE, WARNING, ACTIVE, COOLDOWN
Crusher	IDLE, WARNING, CRUSHING, RECOVERING
Conveyor	STOPPED, FORWARD, REVERSE
Boss machinery	DISABLED, CHARGING, ACTIVE, OVERLOADED
