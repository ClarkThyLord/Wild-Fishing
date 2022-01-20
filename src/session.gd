extends Node
## Session Class



## Public Methods
var money := 0 setget set_money



## Public Methods
func set_money(value : int) -> void:
	money = clamp(value, 0, INF)


func open_main_menu() -> void:
	get_tree().change_scene("res://src/scenes/main_menu/main_menu.tscn")


func open_map() -> void:
	get_tree().change_scene("res://src/scenes/map/map.tscn")


func open_shop() -> void:
	pass


func open_level(stage : String) -> void:
	get_tree().change_scene("res://src/scenes/level/level.tscn")
