extends Reference
class_name Item
## Item Class



## Private Variables
var _item_type : int

var _texture : Texture

var _description : String

var _price : int



## Built-In Virtual Methods
#func _init(
#		texture : Texture,
#		description : String,
#		price : int) -> void:
#	_texture = texture
#	_description = description
#	_price = price



## Public Methods
func get_texture() -> Texture:
	return _texture


func get_description() -> String:
	return _description


func get_price() -> int:
	return _price
