extends "res://src/scenes/level/objects/level_object.gd"
## Level Object Fish Class



## Exported Variables
export(float, 0.75, 10.0) var size := 1.0 setget set_size



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
