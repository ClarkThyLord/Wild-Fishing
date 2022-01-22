extends Control
## Scene Main Menu


## OnReady Variables
onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")

onready var start : Button = get_node("VBoxContainer/VBoxContainer/Start")


## Built-In Virtual Methods
func _ready() -> void:
	if Session.get_intro():
		animation_player.play("Intro")
		yield(animation_player, "animation_finished")
		Session.finished_intro()
	
	if Session.story_progress > 0:
		start.text = "CONTINUE"



## Private Methods
func _on_Start_pressed():
	Session.open_map()


func _on_Settings_pressed():
	Settings.show()


func _on_GitHub_pressed():
	OS.shell_open("https://github.com/ClarkThyLord/Wild-Fishing")
