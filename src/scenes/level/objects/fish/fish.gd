extends "res://src/scenes/level/objects/level_object.gd"
## Level Object Fish Class



## Built-In Virtual Methods
func _ready() -> void:
	set_sprite(NodePath("Sprite"))
	set_collision_polygon(NodePath("CollisionPolygon2D"))
	update_collision_polygon()
