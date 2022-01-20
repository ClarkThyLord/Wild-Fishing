extends Stage
## Level Bay Stage Class



## Private Variables
var _fish_0 := [
]



## Built-In Virtual Methods
func _init() -> void:
	_stage_depth = 500
	
	_ocean = preload("res://assets/scenes/level/stages/bay/ocean.png")
	_waves = preload("res://assets/scenes/level/stages/bay/waves.png")
	_clouds = preload("res://assets/scenes/level/stages/bay/clouds.png")
	_sky = preload("res://assets/scenes/level/stages/bay/sky.png")



## Public Methods
func random(objects : Node2D) -> void:
	_wall_points.clear()
	for s in range(_stage_depth + 32):
		var h = (cos(s / 3) + 1) * 2
		_wall_points.append(h + 1 + randi() % 4)
	
	var y := 375.0
	for i in range(100):
		if randf() < 0.6 and i < 60:
			continue
		
		var obj
		if true:
			obj = preload("res://src/scenes/level/objects/fish/fish.tscn").instance()
			obj.size = clamp(randf() * 4, 0.75, 4.0)
		
		obj.random()
		
		objects.add_child(obj)
		
		var h : float = obj.get_height()
		y += (h * 2) + (randf() * 100)
		obj.position.y = y
