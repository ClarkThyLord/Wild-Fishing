extends Stage
## Level Bay Stage Class



## Built-In Virtual Methods
func _init() -> void:
	_stage_depth = 500


## Public Methods
func random() -> void:
	_wall_points.clear()
	for s in range(_stage_depth + 32):
		var h = (cos(s / 3) + 1) * 2
		_wall_points.append(h + 1 + randi() % 4)
