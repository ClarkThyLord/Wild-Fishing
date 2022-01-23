extends Control
## Shop Scene



# Const
const ItemControl := preload("res://src/scenes/shop/item/item.tscn")



## OnReady Variables
onready var money : Label = get_node("MarginContainer/VBoxContainer/HBoxContainer/Money")

onready var items : VBoxContainer = get_node("MarginContainer/VBoxContainer/ScrollContainer/Items")



## Built-In Virtual Methods
func _ready() -> void:
	update_shop()



## Public Methods
func update_shop() -> void:
	money.text = "$     %07d" % Session.money
	
	for children in items.get_children():
		items.remove_child(children)
		children.queue_free()
	
	var shop_items := Session.get_items()
	for item_name in shop_items:
		var item : Item = shop_items[item_name]
		
		var item_control := ItemControl.instance()
		items.add_child(item_control)
		item_control.set_item(item_name, item)
		item_control.connect("bought", self, "_on_Item_bought")
		item_control.connect("used", self, "_on_Item_used")



## Private Methods
func _on_Exit_pressed():
	Session.open_map()


func _on_Item_bought() -> void:
	print("bought")
	update_shop()


func _on_Item_used() -> void:
	print("used")
	update_shop()
