extends "res://src/scenes/level/objects/level_object.gd"
## Level Object Fish Class



## Exported Variables
export(float, 0.75, 10.0) var size := 1.0 setget set_size



## OnReady Variables
onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")



## Built-In Virtual Methods
func _ready() -> void:
	set_sprite(NodePath("Sprite"))
	set_collision_polygon(NodePath("CollisionPolygon2D"))
	set_direction(direction)
	update_collision_polygon()
	
	if direction == Directions.LEFT:
		position.x  = -80
	elif direction == Directions.RIGHT:
		position.x = 1104



## Public Variables
func set_size(value : float) -> void:
	size = clamp(value, 0.75, 10.0)
	scale = Vector2.ONE * size
	
	set_speed(3 * (10.0 / size))


func hook_by(hook) -> void:
	call_deferred("set_monitorable", false)
	yield(get_tree(),"idle_frame")
	
	get_parent().remove_child(self)
	hook.add_child(self)
	
	position = Vector2.ZERO
	if direction == Directions.LEFT:
		animation_player.play("HookedLeft")
	elif direction == Directions.RIGHT:
		animation_player.play("HookedRight")
	direction = Directions.IDLE
