extends Polygon2D
## Level Wall Class



## Enums
enum WallDirections {
	LEFT = -1,
	RIGHT = 1,
}



## Exported Variables
export(WallDirections) var wall_direction := WallDirections.LEFT setget set_wall_direction

export var wall_pixel_size := 16 setget set_wall_pixel_size

export var wall_points := [] setget set_wall_points



## OnReady Variables
onready var collision_polygon : CollisionPolygon2D = get_node("StaticBody2D/CollisionPolygon2D")




## Public Methods
func set_wall_points(value : Array) -> void:
	wall_points = value
	
	update()


func set_wall_direction(value : int) -> void:
	wall_direction = value
	
	update()


func set_wall_pixel_size(value : int) -> void:
	wall_pixel_size = value
	
	update()


func update() -> void:
	var points := []
	points.append(
			Vector2(0, -3) * wall_pixel_size)
	
	var start_step := 0
	var end_step := wall_points.size()
	for s in range(start_step, end_step):
		var h = wall_points[s]
		var p1 = Vector2(h * wall_direction, s) * wall_pixel_size
		if p1 != points.back():
			points.append(p1)
		points.append(Vector2(h * wall_direction, s + 1) * wall_pixel_size)
	
	points.append(Vector2(0, end_step) * wall_pixel_size)
	
	polygon = PoolVector2Array(points)
	if is_instance_valid(collision_polygon):
		collision_polygon.polygon = polygon
