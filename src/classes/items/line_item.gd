extends Item
class_name LineItem
## Line Item ClassClass



## Private Variables
var _length : float



## Built-In Virtual Methods
func _init(
		texture : Texture,
		description : String,
		price : int,
		length : float) -> void:
	_texture = texture
	_description = description
	_price = price
	
	_length = length



## Public Methods
func get_length() -> float:
	return _length
