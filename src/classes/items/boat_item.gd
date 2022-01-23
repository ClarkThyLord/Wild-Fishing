extends Item
class_name BoatItem
## Boat Item Class



## Built-In Virtual Methods
func _init(
		texture : Texture,
		description : String,
		price : int) -> void:
	_texture = texture
	_description = description
	_price = price
