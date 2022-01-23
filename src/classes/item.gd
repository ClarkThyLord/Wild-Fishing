extends Reference
class_name Item
## Item Class



## Enums
enum ItemType {
	BOAT,
	LINE,
	HOOK,
}



## Private Variables
var _item_type : int

var _texture : Texture

var _description : String

var _price : int



## Built-In Virtual Methods
func _init(
		item_type : int,
		texture : Texture,
		description : String,
		price : int) -> void:
	_item_type = item_type
	_texture = texture
	_description = description
	_price = price
	
	._init()



## Public Methods
func get_item_type() -> int:
	return _item_type


func get_item_type_name() -> String:
	return ItemType.keys()[_item_type]


func get_texture() -> Texture:
	return _texture


func get_description() -> String:
	return _description


func get_price() -> int:
	return _price
