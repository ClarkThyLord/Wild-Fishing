extends "res://src/scenes/level/objects/level_object.gd"
## Level Object Fish Class



## Exported Variables
export(float, 0.75, 10.0) var size := 1.0 setget set_size



## OnReady Variables
onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")



## Built-In Virtual Methods
func _ready() -> void:
	set_object_state(object_state)
	set_sprite(NodePath("Sprite"))
	set_collision_polygon(NodePath("CollisionPolygon2D"))
	update_collision_polygon()



## Public Variables
func set_object_state(value : int) -> void:
	.set_object_state(value)
	
	if not is_instance_valid(animation_player):
		return
	
	match object_state:
		ObjectStates.IDLE:
			animation_player.play("Idle")
		ObjectStates.MOVING_LEFT:
			animation_player.play("SwimmingLeft")
		ObjectStates.MOVING_RIGHT:
			animation_player.play("SwimmingRight")


func set_size(value : float) -> void:
	size = clamp(value, 0.75, 10.0)
	scale = Vector2.ONE * size
	
	set_speed(3 * (10.0 / size))


func hook_by(hook) -> void:
	call_deferred("set_monitorable", false)
	yield(get_tree(),"idle_frame")
	
	get_parent().remove_child(self)
	hook.add_child(self)
	
	position = Vector2(
		-get_width() / 4,
		get_height() / 2
	)
	if object_state == ObjectStates.MOVING_LEFT:
		animation_player.play("CaughtLeft")
	elif object_state == ObjectStates.MOVING_RIGHT:
		animation_player.play("CaughtRight")
	object_state = ObjectStates.CAUGHT


func cash() -> int:
	queue_free()
	return 3 + randi() % 20
