extends CanvasLayer
## Settings Scene



## OnReady Variables
onready var control : ColorRect = get_node("Control")



## Built-In Virtual Methods
func _ready() -> void:
	hide()


func _input(event : InputEvent) -> void:
	if not is_instance_valid(control):
		return
	
	if event is InputEventKey:
		if event.pressed:
			return
		
		match event.scancode:
			KEY_ESCAPE:
				if control.visible:
					hide()
				else:
					show()



## Public Methods
func show() -> void:
	control.show()


func hide() -> void:
	control.hide()



## Private Methods
func _on_Confirm_pressed():
	hide()


func _on_Cancel_pressed():
	hide()


func _on_Reset_pressed():
	Session.reset()
	hide()
