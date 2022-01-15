extends Polygon2D
## Level Wall Class



## Enums
enum StepDirections {
	LEFT = -1,
	RIGHT = 1,
}



## Exported Variables
export var step := 0.0 setget set_step

export var steps := [] setget set_steps

export(StepDirections) var step_direction := StepDirections.LEFT setget set_direction

export var step_pixel_size := 16 setget set_step_pixel_size

export var step_draw_range := 64 setget set_step_draw_range



## OnReady Variables
onready var collision_polygon : CollisionPolygon2D = get_node("StaticBody2D/CollisionPolygon2D")



## Built-In Virtual Methods
func _ready() -> void:
	set_step(step)



## Public Methods
func set_step(value : float) -> void:
	step = value
	
	update()


func set_steps(value : Array) -> void:
	steps = value
	
	update()


func set_direction(value : int) -> void:
	step_direction = value
	
	update()


func set_step_pixel_size(value : int) -> void:
	step_pixel_size = value
	
	update()


func set_step_draw_range(value : int) -> void:
	step_draw_range = value
	
	update()


func update() -> void:
	var points := []
	points.append(Vector2(0, 0 - step) * step_pixel_size)
	
	var start_step := clamp(int(step), 0, INF)
	var end_step := clamp(int(step + step_draw_range), 0, steps.size())
	for s in range(start_step, end_step):
		var h = steps[s]
		var p1 = Vector2(h * step_direction, s - step) * step_pixel_size
		if p1 != points.back():
			points.append(p1)
		points.append(Vector2(h * step_direction, s - step + 1) * step_pixel_size)
	
	points.append(Vector2(0, end_step - step) * step_pixel_size)
	
	polygon = PoolVector2Array(points)
	if is_instance_valid(collision_polygon):
		collision_polygon.polygon = polygon
