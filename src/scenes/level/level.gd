extends Node2D
## Level Class


## Exported Variables
export(int, 0, 100) var wall_step := 16



## OnReady Variables
onready var objects : Node2D = get_node("Objects")

onready var walls : Node2D = get_node("Walls")

onready var wall_left : Polygon2D = get_node("Walls/WallLeft")

onready var wall_left_collision : CollisionPolygon2D = get_node("Walls/WallLeft/StaticBody2D/CollisionPolygon2D")

onready var wall_right : Polygon2D = get_node("Walls/WallRight")

onready var wall_right_collision : CollisionPolygon2D = get_node("Walls/WallRight/StaticBody2D/CollisionPolygon2D")



## Built-In Virtual Methods
func _ready() -> void:
	randomize()
	var steps = 60
	
	var points := []
	points.append(Vector2(0, 0) * wall_step)
	for s in range(steps):
		var h = 3 + randi() % 10
		var p1 = Vector2(h, s) * wall_step
		if points.back() != p1:
			points.append(p1)
		points.append(Vector2(h, s + 1) * wall_step)
	points.append(Vector2(0, steps) * wall_step)
	wall_left.polygon = PoolVector2Array(points)
	wall_left_collision.polygon = wall_left.polygon
	
	points.clear()
	points.append(Vector2(0, 0) * wall_step)
	for s in range(steps):
		var h = 3 + randi() % 10
		var p1 = Vector2(-h, s) * wall_step
		if points.back() != p1:
			points.append(p1)
		points.append(Vector2(-h, s + 1) * wall_step)
	points.append(Vector2(0, steps) * wall_step)
	wall_right.polygon = PoolVector2Array(points)
	wall_right_collision.polygon = wall_right.polygon
