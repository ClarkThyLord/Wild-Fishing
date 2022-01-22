extends Node
## Session Class



## Constants
const NAME = "Wild-Fishing"

const VERSION = "0.0.0"



## Public Methods
var money := 0 setget set_money

var _new_session : Dictionary



## Built-In Virtual Methods
func _ready() -> void:
	_new_session = _get_session().duplicate(true)
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
		var session := _get_session()
		
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
	else:
		_set_session(session)


func reset() -> void:
	_set_session(_new_session.duplicate(true))
	open_main_menu()


func open_main_menu() -> void:
	get_tree().change_scene("res://src/scenes/main_menu/main_menu.tscn")


func open_map() -> void:
	get_tree().change_scene("res://src/scenes/map/map.tscn")


func open_shop() -> void:
	pass


func open_level(stage : String) -> void:
	get_tree().change_scene("res://src/scenes/level/level.tscn")



## Private Methods
func _get_session() -> Dictionary:
	var session := {
		"NAME": NAME,
		"VERSION": VERSION,
	}
	
	for property in get_property_list():
		if property["usage"] == 8192\
				and not (property["name"].begins_with("_")):
			session[property["name"]] = get(property["name"])
	
	return session


func _set_session(session : Dictionary) -> void:
	if session.get("NAME", "") != NAME\
			or session.get("VERSION", "") != VERSION:
		return
	
	for property in session:
		set(property, session[property])
