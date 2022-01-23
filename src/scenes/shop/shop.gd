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
		items.add_child(item_control)
		item_control.set_item(item)



## Private Methods
func _on_Exit_pressed():
	Session.open_map()
