extends Reference
class_name Stage
## Level Stage Class



## Private Methods
var _wall_points := []

var _stage_depth : int



## Public Methods
func random(objects : Node2D) -> void:
	pass


func get_stage_depth() -> int:
	return _stage_depth


func get_wall_points() -> Array:
	return _wall_points
