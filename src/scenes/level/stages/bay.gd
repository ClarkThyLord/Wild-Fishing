extends Stage
## Level Bay Stage Class



## Private Variables
var _fish_0 := [
]



## Built-In Virtual Methods
func _init() -> void:
	_stage_depth = 500



## Public Methods
func random(objects : Node2D) -> void:
	_wall_points.clear()
	for s in range(_stage_depth + 32):
		var h = (cos(s / 3) + 1) * 2
		_wall_points.append(h + 1 + randi() % 4)
	
	for i in range(100):
		if randf() < 0.6 and i < 60:
			continue
		
		var obj
		if true:
			obj = preload("res://src/scenes/level/objects/fish/fish.tscn").instance()
			obj.position.y = i * 100
			obj.size = clamp(randf() * 4, 0.75, 4.0)
		
		obj.random_direction()
		
		objects.add_child(obj)
