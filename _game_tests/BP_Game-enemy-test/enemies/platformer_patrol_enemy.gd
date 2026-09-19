# enemies/platformer_patrol_enemy.gd
class_name PlatformerPatrolEnemy
extends BaseEnemy

# This class intentionally relies on BaseEnemy's default:
# - patrol left/right
# - chase target horizontally
# - edge detection
# - contact damage
#
# Use it directly for simple pigs, rolling hazards, chefs that patrol before custom attack logic, etc.
