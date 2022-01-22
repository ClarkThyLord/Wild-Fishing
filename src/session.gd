extends Node
## Session Class



## Constants
const NAME = "Wild-Fishing"

const VERSION = "0.0.0"



## Public Methods
var money := 0 setget set_money



## Built-In Virtual Methods
func _ready() -> void:
	load_session()


func _exit_tree() -> void:
	save_session()



## Public Methods
func set_money(value : int) -> void:
	money = clamp(value, 0, INF)


func save_session(path := "user://session.save") -> void:
	var save := File.new()
	var opened := save.open(path, File.WRITE)
	if opened == OK:
		var session := {}
		for property in get_property_list():
			if property["usage"] == 8192:
				session[property["name"]] = get(property["name"])
		
		session["NAME"] = NAME
		session["VERSION"] = VERSION
		
		print(session)
		save.store_string(to_json(session))
		save.close()


func load_session(path := "user://session.save") -> void:
	var session := {}
	var save = File.new()
	var opened = save.open(path, File.READ)
	if opened == OK:
		var result := JSON.parse(save.get_as_text())
		if result.error == OK and typeof(result.result) == TYPE_DICTIONARY:
			session = result.result
		save.close()
	
	print(session)
	if session.empty():
		return
	elif session.get("NAME", "") == NAME\
			and session.get("VERSION", "") == VERSION:
		for property in session:
			set(property, session[property])


func open_main_menu() -> void:
	get_tree().change_scene("res://src/scenes/main_menu/main_menu.tscn")


func open_map() -> void:
	get_tree().change_scene("res://src/scenes/map/map.tscn")


func open_shop() -> void:
	pass


func open_level(stage : String) -> void:
	get_tree().change_scene("res://src/scenes/level/level.tscn")
