extends CanvasLayer
## Settings Scene



## OnReady Variables
onready var control : ColorRect = get_node("Control")

onready var audio_master := get_node("Control/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Audio/MarginContainer/Master")



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
	if Session.get_intro():
		return
		
	get_tree().paused = true
	
	update()
	
	control.show()


func hide() -> void:
	get_tree().paused = false
	control.hide()


func update() -> void:
	audio_master.value = Session.setting_audio_master
	
	update_settings()


func update_settings() -> void:
	
	AudioServer.set_bus_mute(
			AudioServer.get_bus_index("Master"), Session.setting_audio_master == 0)
	
	var value := -40 + (45 * (Session.setting_audio_master * 0.01))
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"), value)



## Private Methods
func _on_Confirm_pressed() -> void:
	hide()


func _on_Reset_pressed() -> void:
	Session.reset()
	Theater.hide()
	hide()


func _on_Audio_Master_value_changed(value : float) -> void:
	Session.setting_audio_master = value
	update_settings()
