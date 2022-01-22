extends LevelObject
## Level Object Fish Class



## Exported Variables
export var fish := 0 setget set_fish

export(float, 0.75, 10.0) var size := 1.0 setget set_size

export(float, 0.0, 100_000.0) var worth := 1.0 setget set_worth



## OnReady Variables
onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")



## Built-In Virtual Methods
func _ready() -> void:
	set_object_state(object_state)
	set_sprite(NodePath("Sprite"))
	
	set_fish(fish)
	set_size(size)
	
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


func set_fish(value : int) -> void:
	fish = value
	
	match fish:
		9, 15, 6, 7, 8:
			# SMALL
			set_worth(15)
		10, 11, 12:
			# MEDIUM
			set_worth(25)
		0, 1, 2, 3, 5:
			# BIG
			set_worth(40)
		14:
			# SMALL EXCOTIC
			set_worth(50)
		13:
			# MEDIUM EXCOTIC
			set_worth(10)
		_:
			set_worth(stepify(100 * randf(), 10))
	
	if is_instance_valid(_sprite):
		_sprite.texture =\
				load("res://assets/scenes/level/objects/fish/%s.png" % str(fish))


func set_size(value : float) -> void:
	size = clamp(value, 0.75, 10.0)
	scale = Vector2.ONE * size
	
	set_speed(3 * (10.0 / size))


func set_worth(value : float) -> void:
	worth = clamp(value, 1, INF)


func random() -> void:
	.random()
	
	var min_size := 1.5
	if get_width() <= 12:
		min_size = 2.0
	set_size(clamp(randf() * 4, min_size, 4.0))
	set_speed(speed + (speed * ((randi() % 11) / 10)))


func liquidate() -> int:
	queue_free()
	return int(clamp(worth * size, 1, INF))


func hooked_by(hook) -> void:
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
