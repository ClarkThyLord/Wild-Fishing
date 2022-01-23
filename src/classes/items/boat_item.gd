extends Item
class_name BoatItem
## Boat Item Class



## Private Variables
var _reel_speed : float



## Built-In Virtual Methods
func _init(
		texture : Texture,
		description : String,
		price : int,
		reel_speed : float) -> void:
	_texture = texture
	_description = description
	_price = price
	
	_reel_speed = reel_speed



## Public Methods
func get_reel_speed() -> float:
	return _reel_speed
