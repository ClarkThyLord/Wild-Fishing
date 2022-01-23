tool
extends ColorRect
## Shop Item Class



## Signals
signal bought

signal used



## Exported Variables
export var owned := false setget set_owned

export var usable := false setget set_usable

export var using := false setget set_using

export var item_texture : Texture setget set_item_texture

export var item_name := "" setget set_item_name

export var item_description := "" setget set_item_description

export var item_price := -1 setget set_item_price



## Private Variables
var _item : Item



## OnReady Variables
onready var item_texture_ref : TextureRect = get_node("HBoxContainer/ColorRect/Texture")

onready var item_name_ref : Label = get_node("HBoxContainer/VBoxContainer/HBoxContainer/Name")

onready var item_price_ref : Label = get_node("HBoxContainer/VBoxContainer/HBoxContainer/Price")

onready var item_description_ref : Label = get_node("HBoxContainer/VBoxContainer/Description")

onready var buy : Button = get_node("HBoxContainer/VBoxContainer2/Buy")

onready var use : Button = get_node("HBoxContainer/VBoxContainer2/Use")



## Built-In Virtual Methods
func _ready() -> void:
	set_owned(owned)
	set_usable(usable)
	set_item_texture(item_texture)
	set_item_name(item_name)
	set_item_price(item_price)
	set_item_description(item_description)



## Public Methods
func set_owned(value : bool) -> void:
	owned = value
	
	if is_instance_valid(item_price_ref):
		item_price_ref.visible = not owned
	if is_instance_valid(buy):
		buy.visible = not owned
	if is_instance_valid(use):
		use.visible = owned


func set_usable(value : bool) -> void:
	usable = value
	
	if is_instance_valid(use):
		use.disabled = not usable


func set_using(value : bool) -> void:
	using = value
	
	if is_instance_valid(use):
		use.text = "USING" if using else "USE"


func set_item_texture(value : Texture) -> void:
	item_texture = value
	
	if is_instance_valid(item_texture_ref):
		item_texture_ref.texture = item_texture


func set_item_name(value : String) -> void:
	item_name = value
	
	if is_instance_valid(item_name_ref):
		item_name_ref.text = item_name


func set_item_description(value : String) -> void:
	item_description = value
	
	if is_instance_valid(item_description_ref):
		item_description_ref.text = item_description


func set_item_price(value : int) -> void:
	item_price = value
	
	if is_instance_valid(item_price_ref):
		item_price_ref.text = "| $     %07d" % item_price


func set_item(item_name : String, item : Item) -> void:
	_item = item
	
	set_item_texture(_item.get_texture())
	set_item_name(item_name)
	set_item_description(_item.get_description())
	set_item_price(_item.get_price())
	
	set_owned(item_name in Session.inventory)
	if owned:
		match _item.get_item_type():
			Item.ItemType.BOAT:
				set_usable(true)
				set_using(item_name == Session.boat)
			Item.ItemType.LINE:
				set_usable(true)
				set_using(item_name == Session.line)
			Item.ItemType.HOOK:
				set_usable(true)
				set_using(item_name == Session.hook)
			_:
				set_usable(false)


## Private Methods
func _on_Buy_pressed():
	emit_signal("bought")


func _on_Use_pressed():
	emit_signal("used")
