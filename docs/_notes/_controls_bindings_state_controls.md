
For 2D platformers, the most effective keyboard layout assigns movement to your left hand and jumps/actions to your right. Standard setups usually use Arrow keys or WASD for movement. Popular jump keys include the Spacebar, Z, or C, depending on the level of action required. [1, 2, 3] 

## Standard Keybinding Schemes
While exact bindings vary depending on whether the game features combat or movement-heavy mechanics (like dashing or wall-jumping), the following three setups are heavily favored by the PC community: [3, 4, 5] 

### 1. The "WASD + Space" Standard
This configuration is highly popular for modern platformers as it translates 3D gaming muscle memory over to a 2D plane. [4] 

* Move Left: A
* Move Right: D
* Jump: Spacebar
* Crouch: Left Ctrl or S
* Action/Shoot: K, L, or Mouse Click [1, 4, 6, 7, 8, 9] 

### 2. The Arrow Key Classic
This layout is common in indie games and retro titles because it separates the movement completely from the action keys. [3, 10] 

* Move Left: Left Arrow
* Move Right: Right Arrow
* Look Up / Enter Door: Up Arrow
* Crouch: Down Arrow
* Jump: Spacebar or Z
* Attack/Action: X, C, or V [3, 11] 

### 3. The "Z, X, C" Setup
Inspired by classic emulator layouts, this scheme keeps all actions compact on the keyboard, allowing the player's fingers to rest in a natural arc.

* Movement: Arrow keys
* Jump: X
* Attack: Z
* Dash / Special: C [3] 

---

## Key Design Considerations
If you are designing a platformer, consider the following layout tips sourced from community discussions:

* The Thumb Factor: Using the Spacebar for jumping is highly suggested for WASD layouts, as it keeps your fingers from cramping. [1, 4, 12] 
* Two-Handed vs. One-Handed: Design your controls so that the player is not forced to hold too many keys simultaneously with just one hand. [13, 14] 
* Remapping: The consensus in game design is to always allow for custom key remapping to accommodate accessibility needs and user preferences. [9, 15, 16] 

To learn more about what layout works best or to study control mechanics, you can look into the discussions found in the [GameFAQs Keyboard control schemes](https://gamefaqs.gamespot.com/boards/916373-pc/67186990) thread or browse the thoughts on [Reddit's gamedesign community](https://www.reddit.com/r/gamedesign/comments/q0yp7a/keyboard_controls_and_2d_platformers/).
Would you like to discuss controls for a specific type of 2D platformer (e.g., precision platformer, metroidvania with combat, or a puzzle-platformer)? I can help tailor the optimal keybindings for your specific style of game.

---

To handle this deep mechanical mix, you need a control scheme that prevents finger cramping during intense platforming while still allowing quick weapon tactical swaps.
Here is the ultimate modern layout designed for your hybrid game, utilizing a WASD + Mouse hybrid or a WASD + Keyboard pure setup.

------------------------------
## The Hybrid Layout (Recommended)
Using the mouse for off-hand aiming and swapping offers the most precise control for modern gamers.

### 🌍 Top-Down Hub Controls

* Movement: W, A, S, D (Walk/Run via analog emulation or auto-run toggle)
* Interact with NPCs: E or Left Click
* Open Pause Menu: Esc

### 🏃 Platformer Movement

* Move Left / Right: A / D
* Crouch / Crouch-Walk: S (Hold)
* Slope Slide: Press S while running on a slope
* Jump / Double Jump: Spacebar
* Dash / Roll / Slide: Left Shift (Directional based on A/D)
* Wall Slide / Ledge Grab / Climb: Automatic when moving toward a wall/ledge
* Ladder Climb: W (Up) / S (Down) [1] 

### ⚔️ Weapon & Powerup System

* Attack (Main Hand / Two-Handed): Left Click
* Use Off-Hand (Shield / Grease / Smoke): Right Click
* Swap Main & Off-Hand Slots: Q (Instantly swaps your active setup)
* Drop / Cycle Category: G (If they manually want to drop a weapon)
* Pick Up New Item: E (Replaces current category automatically and drops the old one)

------------------------------
### Alternative: Pure Keyboard Layout (Retro-Modern)
If your game does not use free-aiming for items like the net launcher, a pure keyboard setup keeps both hands on the keys.

* Movement: W, A, S, D (Same as above)
* Jump / Double Jump: Spacebar
* Dash / Roll: Left Shift
* Main Attack: J
* Off-Hand / Block: K
* Interact / Pick Up: E
* Swap Weapon Slots: I or Q

------------------------------
### 🛠️ Handling the "Tricky" Weapon Swap Logic
Because picking up an item forces an automatic category replacement, your UI and control feedback must be flawless to avoid player frustration.

* The Two-Handed Rule: If a player equips a Two-Handed weapon (Greatsword), visually "grey out" or disable the Off-Hand UI slot. If they press the Off-Hand key, play a quick "fizzle" sound or visual cue showing it is blocked.
* The Drop Drop Mechanic: When a player presses E to pick up a new weapon, apply a slight upward and outward physics force to the old weapon. This makes it bounce onto the ground nearby so players can easily retrieve it if they made a mistake. [2, 3] 
* Smart UI Anchors: Keep a small weapon widget in the bottom-left or bottom-right corner showing:
* Slot 1: Main Hand icon + Off Hand icon
   * Slot 2: Two-Handed Weapon icon
   * Active Frame: A bright border showing which slot is currently drawn.

---

That fits perfectly. Mapping the two-handed secondary mode to the Off-Hand key maintains exact muscle memory across all weapon types. The player always uses one button for primary actions and another for secondary actions. [1] 
Here is how the refined control logic and UI adapt to this mechanic.
------------------------------
## Updated Keybinding Layout (WASD + Mouse)## ⚔️ Weapon & Powerup Actions

* Attack (Main Hand / Two-Handed Primary): Left Click
* One-Handed: Swings sword / fires pistol.
   * Two-Handed: Heavy Greatsword slash / fires Net Launcher. [2, 3] 
* Off-Hand / Secondary Action: Right Click
* Dual-Wield: Raises Shield / throws Grease or Smoke.
   * Two-Handed: Triggers Greatsword Block (or Spin) / fires Net Detonation (or Melee Stock Whip). [4, 5, 6, 7, 8] 
* Swap Active Setup: Q
* Switches between the One-Handed pair (Sword + Shield) and the Two-Handed weapon (Net Launcher). [9] 
* Interact / Pick Up Item: E
* Automatically replaces the matching category and drops the old item onto the floor.

------------------------------
### ⚙️ Under-the-Hood Interaction Logic
To prevent bugs when dropping, swapping, and picking up items, your inventory code should use a three-slot data structure:
```
Inventory = {
    "main_hand": Item_Data (Sword, Pistol, etc.),
    "off_hand":  Item_Data (Shield, Smoke Bomb, etc.),
    "two_handed": Item_Data (Greatsword, Net Launcher, etc.)
}
```

### The Pickup Loop
When the player presses E over a new item on the ground:

1. Check Item Type: Is it a Main-Hand, Off-Hand, or Two-Handed weapon?
2. Spawn & Drop: Instantly spawn the old item from that exact slot back into the world physics loop (bouncing it slightly into the air).
3. Equip New: Write the new item's data into that slot.
4. Auto-Equip Check: If they just picked up a Two-Handed weapon, automatically switch their active visual state to the Two-Handed slot so they can use it immediately.

------------------------------
### 📺 UI Behavior & Visual Feedback
To make this clear to the player, the Heads-Up Display (HUD) needs to adapt dynamically based on what is currently held in their hands.

* When Active Slot is One-Handed:
* Show two side-by-side weapon frames (e.g., Left Frame: Sword, Right Frame: Shield).
   * Bind them visually to Left Click and Right Click icons. [10] 
* When Active Slot is Two-Handed:
* Merge the two HUD frames into one single large, highlighted weapon card.
   * Split the bottom text of that card into two distinct labels: [L-Click] Primary Fire and [R-Click] Alt-Fire Mode.

---

Here is a complete, scalable Hierarchical Finite State Machine (HFSM) architecture for Godot 4 (GDScript). [1] 
Because your game has two vastly different gameplay modes (Top-Down Hub vs. 2D Platformer), 
the cleanest approach is to use a Master State Machine that switches between a HubState and a PlatformerState. 

Inside the PlatformerState, you run a Sub-State Machine 
to handle the intense platforming physics (Sliding, Wall Sliding, Ledge Grabbing, Double Jumping).

------------------------------
## 📁 Project Node Structure
Set up your Player Scene in Godot exactly like this:

```
Player (CharacterBody2D)
├── CollisionShape2D
├── Sprite2D (or AnimatedSprite2D)
├── WeaponController (Node)  # Handles your inventory/swapping
└── StateMachine (Node)      # The Master State Machine
    ├── HubState (Node)
    └── PlatformerState (Node)  # This acts as a Sub-State Machine
        ├── IdleState (Node)
        ├── RunState (Node)
        ├── AirState (Node)    # Handles Jump, Double Jump, Fall
        ├── SlideState (Node)  # Handles Crouching, Slope Sliding, Rolls
        ├── WallState (Node)   # Handles Wall Slide & Ledge Grab
        └── LadderState (Node)
```

------------------------------
### 1. The Base State Script (state.gd)
Create a script named state.gd (and make it a global class or just load it). This is the blueprint all other states will inherit from. [2, 3, 4] 

```gdscript
# state.gd
extends Node
class_name State

var player: CharacterBody2D
var state_machine: Node

func enter() -> void:
	pass

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
```

------------------------------

### 2. The Master State Machine Manager (state_machine.gd)
Attach this script to your StateMachine node. It manages state transitions and passes Godot's built-in loops down to the active state. [5, 6] 

```gdscript
# state_machine.gd
extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	# Get the root player node (assumes Player is parent or grandparent)
	var player = get_parent()
	
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.player = player
			child.state_machine = self
			
			# If this is a nested sub-state machine (like PlatformerState), initialize its children too
			if child.get_child_count() > 0:
				_initialize_sub_states(child, player)

	if initial_state:
		current_state = initial_state
		current_state.enter()

func _initialize_sub_states(sub_machine: Node, player_node: CharacterBody2D) -> void:
	for child in sub_machine.get_children():
		if child is State:
			sub_machine.states[child.name.to_lower()] = child
			child.player = player_node
			child.state_machine = sub_machine

func change_state(new_state_name: String) -> void:
	var target_state = states.get(new_state_name.to_lower())
	if not target_state:
		return
		
	if current_state:
		current_state.exit()
		
	current_state = target_state
	current_state.enter()

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
```

------------------------------
### 3. The Platformer State Machine (platformer_state.gd)
Attach this script to the PlatformerState node. 
It acts as a State and a sub-state manager. 
It contains all the shared movement variables (like gravity and speed) 
so individual states don't get messy. [7] 

```gdscript
# platformer_state.gd
extends State

# Movement Physics Constants
@export var SPEED := 300.0
@export var RUN_SPEED := 450.0
@export var JUMP_VELOCITY := -400.0
@export var DASH_SPEED := 700.0
@export var SLIDE_DECEL := 400.0
@export var WALL_SLIDE_SPEED := 100.0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

# Jump tracking
var max_jumps := 2
var current_jumps := 0

# Sub-state tracking
var current_sub_state: State
var states: Dictionary = {}

func enter() -> void:
	# Default to idle sub-state when entering platformer mode
	change_sub_state("idlestate")

func exit() -> void:
	if current_sub_state:
		current_sub_state.exit()

func change_sub_state(new_state_name: String) -> void:
	var target = states.get(new_state_name.to_lower())
	if not target: return
	if current_sub_state: current_sub_state.exit()
	current_sub_state = target
	current_sub_state.enter()

func handle_input(event: InputEvent) -> void:
	if current_sub_state: current_sub_state.handle_input(event)

func update(delta: float) -> void:
	if current_sub_state: current_sub_state.update(delta)

func physics_update(delta: float) -> void:
	if current_sub_state: current_sub_state.physics_update(delta)
	player.move_and_slide()
```

------------------------------
### 4. Code Blocks for Key Platforming Sub-States
Create individual scripts for the nodes inside PlatformerState. Make sure each one extends State. [8] 

#### A. Air State (air_state.gd) — Handles Jumps, Double Jumps, and Falls
```gdscript
# air_state.gd
extends State

@onready var p_machine = get_parent() # Access physics configurations

func enter() -> void:
	# If we entered air from a jump, it's already counted. 
	# If we walked off a ledge, consume the first jump so they only get 1 double jump.
	if player.is_on_floor():
		p_machine.current_jumps = 0

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if p_machine.current_jumps < p_machine.max_jumps - 1:
			p_machine.current_jumps += 1
			player.velocity.y = p_machine.JUMP_VELOCITY
			# Play double jump VFX/Animation here

func physics_update(delta: float) -> void:
	# Apply normal gravity
	player.velocity.y += p_machine.gravity * delta
	
	# Horizontal air drift control
	var input_dir := Input.get_axis("move_left", "move_right")
	if input_dir:
		player.velocity.x = input_dir * p_machine.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, p_machine.SPEED * delta)
		
	# Transition checks
	if player.is_on_floor():
		if input_dir != 0:
			p_machine.change_sub_state("runstate")
		else:
			p_machine.change_sub_state("idlestate")
			
	# Wall Slide Check (Player pressing into a wall while falling)
	if player.is_on_wall() and input_dir == sign(player.get_wall_normal() * -1):
		if player.velocity.y > 0:
			p_machine.change_sub_state("wallstate")
```

#### B. Slide State (slide_state.gd) — Handles Crouching, Slope Sliding, and Dash/Roll

```gdscript
# slide_state.gd
extends State

@onready var p_machine = get_parent()
var is_dashing := false
var dash_timer := 0.0
var dash_duration := 0.25

func enter() -> void:
	# Determine if this is a high-speed dash/roll or a static crouch
	var input_dir := Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed("dash") and input_dir != 0:
		is_dashing = true
		dash_timer = dash_duration
		player.velocity.x = input_dir * p_machine.DASH_SPEED
		# Change collision shape size here for lower profile if needed
	elif player.is_on_floor():
		is_dashing = false
		# Crouch/Slope slide setup

func physics_update(delta: float) -> void:
	# 1. Dash/Roll Physics Loop
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			p_machine.change_sub_state("idlestate")
		return
		
	# 2. Normal Crouch / Slope Sliding Loop
	var input_dir := Input.get_axis("move_left", "move_right")
	
	# Check if on a slope using the floor normal vector
	var floor_normal = player.get_floor_normal()
	if floor_normal.x != 0: # Floor is angled
		# Apply gravity acceleration down the slope
		player.velocity.x += floor_normal.x * p_machine.gravity * delta
	else:
		# Decelerate on flat ground if crouching
		if input_dir != 0:
			player.velocity.x = input_dir * (p_machine.SPEED * 0.5) # Crouch walk
		else:
			player.velocity.x = move_toward(player.velocity.x, 0, p_machine.SLIDE_DECEL * delta)

	# Apply gravity just in case they slide off a ridge
	if not player.is_on_floor():
		p_machine.change_sub_state("airstate")
		
	# Stand up check
	if not Input.is_action_pressed("crouch") and not is_dashing:
		# Optional: Raycast check here to make sure there is room to stand up
		if input_dir != 0:
			p_machine.change_sub_state("runstate")
		else:
			p_machine.change_sub_state("idlestate")
```

#### C. Wall State (wall_state.gd) — Handles Wall Sliding & Ledge Grab
```gdscript
# wall_state.gd
extends State

@onready var p_machine = get_parent()

func physics_update(delta: float) -> void:
	# Clamp descending speed to create the sliding friction effect
	player.velocity.y = min(player.velocity.y + p_machine.gravity * delta, p_machine.WALL_SLIDE_SPEED)
	
	var input_dir := Input.get_axis("move_left", "move_right")
	var wall_normal = player.get_wall_normal()
	
	# Wall Jump
	if Input.is_action_just_pressed("jump"):
		# Push away from the wall violently
		player.velocity.y = p_machine.JUMP_VELOCITY
		player.velocity.x = wall_normal.x * p_machine.SPEED * 1.2
		p_machine.current_jumps = 1 # Consume first jump
		p_machine.change_sub_state("airstate")
		return

	# Fall off wall checks
	if not player.is_on_wall() or player.is_on_floor():
		p_machine.change_sub_state("idlestate")
		return
		
	# If player pulls the joystick clean away from the wall, make them fall off
	if input_dir == sign(wall_normal.x):
		p_machine.change_sub_state("airstate")
```

------------------------------
#### 5. Weapon Inventory Switching Logic
To tie the weapon swapping mechanics smoothly alongside your state machine, attach this script to a node named WeaponController.
```gdscript
# weapon_controller.gd
extends Node

enum WeaponSlot { ONE_HANDED, TWO_HANDED }

var current_slot = WeaponSlot.ONE_HANDED

var inventory = {
	"main_hand": null,   # e.g., "Sword"
	"off_hand": null,    # e.g., "Shield"
	"two_handed": null   # e.g., "Greatsword"
}

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("swap_weapon"):
		toggle_weapon_slot()
		
	if event.is_action_pressed("attack_primary"):
		use_weapon(true)
		
	if event.is_action_pressed("attack_secondary"):
		use_weapon(false)

func toggle_weapon_slot() -> void:
	if current_slot == WeaponSlot.ONE_HANDED:
		if inventory["two_handed"] != null:
			current_slot = WeaponSlot.TWO_HANDED
			print("Switched to Two-Handed setup!")
	else:
		current_slot = WeaponSlot.ONE_HANDED
		print("Switched to One-Handed pair setup!")
	update_hud_display()

func use_weapon(is_primary: bool) -> void:
	if current_slot == WeaponSlot.ONE_HANDED:
		if is_primary and inventory["main_hand"]:
			print("Attacking with: ", inventory["main_hand"])
		elif not is_primary and inventory["off_hand"]:
			print("Using Off-Hand utility: ", inventory["off_hand"])
	else:
		if inventory["two_handed"]:
			if is_primary:
				print("Two-Handed Heavy Attack: ", inventory["two_handed"])
			else:
				print("Two-Handed Alt Mode Action: ", inventory["two_handed"])

# Call this from your World logic when player overlaps a weapon drop and hits 'E'
func pickup_item(category: String, weapon_name: String) -> void:
	# Category expected: "main_hand", "off_hand", or "two_handed"
	if inventory[category] != null:
		_drop_old_weapon_into_world(inventory[category])
		
	inventory[category] = weapon_name
	print("Equipped new ", category, ": ", weapon_name)
	
	# Auto-swap behavior logic
	if category == "two_handed":
		current_slot = WeaponSlot.TWO_HANDED
		
	update_hud_display()

func _drop_old_weapon_into_world(old_weapon_name: String) -> void:
	print("Physics-dropping old weapon back to map: ", old_weapon_name)
	# Instantiate your ItemDrop scene, apply a Rigidbody impulse outward here

func update_hud_display() -> void:
	# Signal out or call your UI node to update active/inactive borders
	pass
```
