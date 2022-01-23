extends Node
## Map Scene



## OnReady Variables
onready var money : Label = get_node("Texture/InfoPanel/Money")



## Built-In Virtual Methods
func _ready() -> void:
	money.text = "$     %07d" % Session.money
	
	if not "Boating Lessons" in Session.inventory:
		_get_area_text("Bay").text = "?"
	if not "Sailing Lessons" in Session.inventory:
		_get_area_text("ShallowWaters").text = "?"



## Private Methods
func _get_area_text(area_name : String) -> Label:
	return get_node_or_null(area_name + "/Label") as Label


func _set_area_text_color(area_name : String, color : Color) -> void:
	var label := _get_area_text(area_name)
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
			"Bay":
				if not "Boating Lessons" in Session.inventory:
					return
				continue
			"ShallowWaters":
				if not "Sailing Lessons" in Session.inventory:
					return
				continue
			_:
				Session.open_level(area_name)


func _on_Area_mouse_exited(area_name : String):
	_set_area_text_color(area_name, Color.white)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
