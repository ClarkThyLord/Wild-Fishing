extends Node
## Map Class


func _on_Home_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			print("HOME")
