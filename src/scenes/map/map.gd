extends Node
## Scene Map



## Private Methods
func _on_Area_input_event(
		viewport : Viewport,
		event : InputEvent,
		shape_idx : int,
		area_name : String) -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	if event is InputEventMouseButton:
		if event.pressed:
			return
		
		match area_name:
			"shop":
				Session.open_shop()
			_:
				Session.open_level(area_name)


func _on_Area_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_Area_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
