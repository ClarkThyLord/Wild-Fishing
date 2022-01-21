extends Node
## Scene Map



## OnReady Variables
onready var money : Label = get_node("Texture/InfoPanel/Money")



## Built-In Virtual Methods
func _ready() -> void:
	money.text = "$     %07d" % Session.money



## Private Methods
func _set_area_text_color(area_name : String, color : Color) -> void:
	var label : Label = get_node_or_null(area_name + "/Label")
	if is_instance_valid(label):
		label.modulate = color


func _on_Area_input_event(
		viewport : Viewport,
		event : InputEvent,
		shape_idx : int,
		area_name : String) -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	_set_area_text_color(area_name, Color("858585"))
	if event is InputEventMouseButton:
		if event.pressed:
			return
		
		match area_name:
			"Shop":
				Session.open_shop()
			_:
				Session.open_level(area_name)


func _on_Area_mouse_exited(area_name : String):
	_set_area_text_color(area_name, Color.white)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
