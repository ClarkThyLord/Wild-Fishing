extends Control
## Shop Scene



# Const
const ItemControl := preload("res://src/scenes/shop/item/item.tscn")



## OnReady Variables
onready var items : VBoxContainer = get_node("MarginContainer/VBoxContainer/ScrollContainer/Items")



## Built-In Virtual Methods
func _ready() -> void:
	var shop_items := Session.get_items()
	for item_name in shop_items:
		var item : Item = shop_items[item_name]
		
		var item_control := ItemControl.instance()
		
		item_control.item_texture = item.get_texture()
		item_control.item_name = item_name
		item_control.item_description = item.get_description()
		item_control.item_price = item.get_price()
		
		items.add_child(item_control)
