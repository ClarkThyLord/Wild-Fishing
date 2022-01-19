extends Node
## Scene Map



## Private Methods
func _on_Shop_input_event(
		viewport  : Viewport, event : InputEvent, shape_idx : int):
	if event is InputEventMouseButton:
		if event.pressed:
			Session.open_shop()


func _on_Bay_input_event(
		viewport  : Viewport, event : InputEvent, shape_idx : int):
	if event is InputEventMouseButton:
		if event.pressed:
			Session.open_level("Bay")
