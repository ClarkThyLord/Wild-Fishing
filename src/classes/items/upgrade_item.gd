extends Item
class_name UpgradeItem
## Upgrade Item Class



## Built-In Virtual Methods
func _init(
		texture : Texture,
		description : String,
		price : int) -> void:
	_texture = texture
	_description = description
	_price = price
