extends Control
## Scene Main Menu



## Private Methods
func _on_Start_pressed():
	Session.open_map()


func _on_Settings_pressed():
	Settings.show()


func _on_GitHub_pressed():
	OS.shell_open("https://github.com/ClarkThyLord/Wild-Fishing")
