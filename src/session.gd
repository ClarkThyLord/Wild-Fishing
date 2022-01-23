extends Node
## Session Class



## Enums
enum StoryProgress {
	NEW_GAME = 0,
	TUTORIAL = 1,
	STORY_1 = 2,
	STORY_2 = 4,
}



## Constants
const NAME = "Wild-Fishing"

const VERSION = "0.0.0"



## Public Variables
var story_progress : int = StoryProgress.NEW_GAME

var money := 0 setget set_money

var inventory := [
	"Wood Boat",
	"Fishing Line",
	"Fishing Hook",
]

var boat := "Wood Boat"

var line := "Fishing Line"

var hook := "Fishing Hook"



## Private Variables
var _intro := true

var _level_stage := "COAST"

var _new_session : Dictionary

var _items := {
	"Wood Boat": BoatItem.new(
		preload("res://assets/scenes/level/boat/wood_boat.png"),
		"Simple wooden boat.",
		0,
		16.0
	),
	"Fishing Line": LineItem.new(
		preload("res://assets/scenes/level/line/fishing_line.png"),
		"Simple fishing line.",
		0,
		200.0
	),
	"Fishing Hook": HookItem.new(
		preload("res://assets/scenes/level/hook/fishing_hook.png"),
		"Simple fishing hook.",
		0,
		16.0,
		16.0
	),
	"Boating Lessons": UpgradeItem.new(
		preload("res://assets/items/boating_lessons.png"),
		"Allows you to explore a new area on the Map.",
		1_000
	),
	"Sailing Lessons": UpgradeItem.new(
		preload("res://assets/items/sailing_lessons.png"),
		"Allows you to explore a new area on the Map.",
		2_500
	),
	"Heavy Anchor": UpgradeItem.new(
		preload("res://assets/items/heavy_anchor.png"),
		"Allows you to explore a new area on the Map.",
		5_000
	),
	"Chartplotter": UpgradeItem.new(
		preload("res://assets/items/chartplotter.png"),
		"Allows you to explore a new area on the Map.",
		10_000
	),
}



## Built-In Virtual Methods
func _ready() -> void:
	_new_session = _get_session().duplicate(true)
	load_session()


func _exit_tree() -> void:
	save_session()



## Public Methods
func get_intro() -> bool:
	return _intro


func finished_intro() -> void:
	_intro = false


func set_money(value : int) -> void:
	money = clamp(value, 0, INF)


func get_level_stage() -> String:
	return _level_stage


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
	save_session()
	open_main_menu()


func open_main_menu() -> void:
	get_tree().change_scene("res://src/scenes/main_menu/main_menu.tscn")


func open_map() -> void:
	get_tree().change_scene("res://src/scenes/map/map.tscn")


func open_shop() -> void:
	get_tree().change_scene("res://src/scenes/shop/shop.tscn")


func open_level(stage_name : String) -> void:
	get_tree().change_scene("res://src/scenes/level/level.tscn")
	_level_stage = stage_name


func get_items() -> Dictionary:
	return _items


func get_boat_used() -> BoatItem:
	return _items[boat]


func get_line_used() -> LineItem:
	return _items[line]


func get_hook_used() -> HookItem:
	return _items[hook]



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
