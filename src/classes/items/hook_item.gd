extends Item
class_name HookItem
## Hook Item Class



## Private Variables
var _plunging_speed : float

var _strafing_speed : float



## Built-In Virtual Methods
func _init(
		texture : Texture,
		description : String,
		price : int,
		plunging_speed : float,
		strafing_speed : float) -> void:
	_texture = texture
	_description = description
	_price = price
	
	_plunging_speed = plunging_speed
	_strafing_speed = strafing_speed



## Public Methods
func get_plunging_speed() -> float:
	return _plunging_speed


func get_strafing_speed() -> float:
	return _strafing_speed
