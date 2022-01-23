extends Reference
class_name Stage
## Level Stage Class



## Private Methods
var _fish_count : int

var _wall_points := []

var _stage_depth : int

var _ocean : Texture

var _waves : Texture

var _clouds : Texture

var _sky : Texture



## Public Methods
func random(objects : Node2D) -> void:
	pass


func get_wall_points() -> Array:
	return _wall_points


func get_stage_depth() -> int:
	return _stage_depth


func get_ocean_texture() -> Texture:
	return _ocean


func get_waves_texture() -> Texture:
	return _waves


func get_clouds_texture() -> Texture:
	return _clouds


func get_sky_texture() -> Texture:
	return _sky

func get_fish_count() -> int:
	return _fish_count
