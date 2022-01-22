extends Control
## Scene Main Menu



onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")


## Built-In Virtual Methods
func _ready() -> void:
	if Session.get_intro():
		animation_player.play("Intro")
		yield(animation_player, "animation_finished")
		Session.finished_intro()



## Private Methods
func _on_Start_pressed():
	Session.open_map()


func _on_Settings_pressed():
	Settings.show()


func _on_GitHub_pressed():
	OS.shell_open("https://github.com/ClarkThyLord/Wild-Fishing")
