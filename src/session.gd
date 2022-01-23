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

var setting_audio_master := 70



## Private Variables
var _music : AudioStreamPlayer

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
	
	"Rigged Boat": BoatItem.new(
		preload("res://assets/scenes/level/boat/rigged_boat.png"),
		"A wood boat fitted to be more comfortable.",
		250,
		20.0
	),
	"Thick Line": LineItem.new(
		preload("res://assets/scenes/level/line/thick_line.png"),
		"Thick long line, great for fishing big fish.",
		125,
		400.0
	),
	"Weighted Hook": HookItem.new(
		preload("res://assets/scenes/level/hook/weighted_hook.png"),
		"Hook with attached weight making it sink faster.",
		200,
		20.0,
		16.0
	),
	
	"Sheeted Boat": BoatItem.new(
		preload("res://assets/scenes/level/boat/sheeted_boat.png"),
		"A metal sheet makes the boat's hull lighter.",
		750,
		22.0
	),
	"Long Line": LineItem.new(
		preload("res://assets/scenes/level/line/long_line.png"),
		"Sturdy long line, great for fishing deep sea fish.",
		300,
		750.0
	),
	"Sharp Hook": HookItem.new(
		preload("res://assets/scenes/level/hook/sharp_hook.png"),
		"Sharp hook, makes it easier to catch and navigate.",
		500,
		20.0,
		20.0
	),
	
	"Iron Boat": BoatItem.new(
		preload("res://assets/scenes/level/boat/iron_boat.png"),
		"Sturdy boat made out of iron.",
		1500,
		24.0
	),
	"Sturdy Line": LineItem.new(
		preload("res://assets/scenes/level/line/sturdy_line.png"),
		"Very sturdy line made for fishing.",
		750,
		900.0
	),
	"Double Hook": HookItem.new(
		preload("res://assets/scenes/level/hook/double_hook.png"),
		"Double the hook!",
		1000,
		22.0,
		20.0
	),
	
	"Tipped Boat": BoatItem.new(
		preload("res://assets/scenes/level/boat/tipped_boat.png"),
		"Golden tipped boat, because why not?",
		2500,
		25.0
	),
	"Fine Line": LineItem.new(
		preload("res://assets/scenes/level/line/fine_line.png"),
		"Very fine line great for fishing lots of fish.",
		1000,
		1000.0
	),
	"Heavy Hook": HookItem.new(
		preload("res://assets/scenes/level/hook/heavy_hook.png"),
		"The heavier they are, the faster they fall!",
		1500,
		24.0,
		18.0
	),
	
	"Sheltered Boat": BoatItem.new(
		preload("res://assets/scenes/level/boat/sheltered_boat.png"),
		"Shelter on a boat? Who would've thought",
		3000,
		26.0
	),
	"Extremely Long Line": LineItem.new(
		preload("res://assets/scenes/level/line/extremely_long_line.png"),
		"Who would need soo much line?",
		1500,
		2000.0
	),
	"Gold Tipped Hook": HookItem.new(
		preload("res://assets/scenes/level/hook/gold_tipped_hook.png"),
		"Gold on a hook, does it attract fish?",
		2500,
		24.0,
		22.0
	),
	
	"Gold Boat": BoatItem.new(
		preload("res://assets/scenes/level/boat/golden_boat.png"),
		"A boat made out of gold... oh, and it can float too.",
		6000,
		27.0
	),
	"Military Line": LineItem.new(
		preload("res://assets/scenes/level/line/military_line.png"),
		"Line that can tie go around the world and back.",
		4000.0,
		3000.0
	),
	"Fancy Hook": HookItem.new(
		preload("res://assets/scenes/level/hook/fancy_hook.png"),
		"Scientists were so preoccupied with whether they could, they didn't stop to think if they should.",
		5000,
		25.0,
		27.0
	),
	
#	"": BoatItem.new(
#		preload(""),
#		"",
#		0,
#		.0
#	),
#	"": LineItem.new(
#		preload(""),
#		"",
#		0,
#		.0
#	),
#	"": HookItem.new(
#		preload(""),
#		"",
#		0,
#		.0,
#		.0
#	),
	
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
	_music = AudioStreamPlayer.new()
	add_child(_music)
	_music.stream = preload("res://assets/audio/slow_stride_loop.ogg")
	_music.pause_mode = Node.PAUSE_MODE_PROCESS
	_music.play()
	
	_new_session = _get_session().duplicate(true)
	load_session()
	
	Settings.update_settings()


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
