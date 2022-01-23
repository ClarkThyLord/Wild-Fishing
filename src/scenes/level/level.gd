extends Node
## Level Scene



## Enums
enum Stages {
	COAST,
	BAY,
	SHALLOW_WATERS,
	OCEAN,
	THE_DEEP,
}

enum GameStates {
	IDLE,
	CASTING,
	FISHING,
	START_REELING,
	REELING,
	STOP_REELING,
}



## Exported Variables
export(Stages) var stage = Stages.COAST setget set_stage



## Private Variables
var _resting := false

var _game_state : int = GameStates.IDLE

var _stage : Stage

var _depth := 0.0



## OnReady Variables
onready var animation_player := get_node("AnimationPlayer")

onready var camera := get_node("Camera2D")

onready var hook := get_node("Camera2D/Hook")

onready var objects : Node2D = get_node("Objects")

onready var walls : Node2D = get_node("Walls")

onready var wall_left := get_node("Walls/WallLeft")

onready var wall_right := get_node("Walls/WallRight")

onready var level_floor := get_node("Floor")

onready var hud := get_node("HUD")

onready var sky : Sprite = get_node("Background/Sky")

onready var clouds : Sprite = get_node("Background/Clouds")

onready var ocean_top : Sprite = get_node("Background/OceanTop")

onready var waves_back : Sprite = get_node("Background/WavesBack")

onready var boat : Sprite = get_node("Background/Boat")

onready var waves_front = get_node("Background/WavesFront")

onready var ocean_bottom = get_node("Camera2D/OceanBottom")

onready var line : Line2D = get_node("Background/Line")



## Built-In Virtual Methods
func _ready() -> void:
	randomize()
	
	set_stage(
			stage_name_to_enum(Session.get_level_stage()))
	
	if not Session.story_progress & Session.StoryProgress.TUTORIAL:
		Session.story_progress += Session.StoryProgress.TUTORIAL
		Theater.show("CONTROLS", [
			preload("res://assets/controls/controls.png")
		])


func _process(delta : float) -> void:
	if _resting:
		return
	
	if Input.is_action_just_released("game_start"):
		if _game_state == GameStates.IDLE:
			_cast()
		elif _game_state == GameStates.FISHING:
			_start_reeling()
	
	if _game_state == GameStates.REELING and _depth <= 0.0:
		_stop_reeling()
	
	var playing := false
	var plunging_speed := 16
	hook.hook_state = hook.HookStates.IDLE
	if _game_state == GameStates.FISHING:
		_set_depth(_depth + plunging_speed * delta)
		playing = true
		hook.hook_state = hook.HookStates.PLUNGING
	elif _game_state == GameStates.REELING\
			or _game_state == GameStates.START_REELING:
		_set_depth(_depth + -plunging_speed * delta)
		playing = true
		hook.hook_state = hook.HookStates.RISING
	
	if playing:
		if _depth < _stage.get_stage_depth() - (300 / 16):
			camera.position.y = 300 + _depth * 16
		else:
			hook.position.y = clamp(hook.position.y + 16, -INF, 200)
			if _game_state == GameStates.FISHING and hook.position.y >= 200:
				_game_state = GameStates.REELING
	
	hud.update_depth(_depth)
	
	line.set_point_position(1, Vector2(
		hook.global_position.x,
		hook.global_position.y - 40
	))
	
	if _game_state == GameStates.IDLE and 30 > objects.get_child_count():
		start_resting()



## Public Methods
func set_stage(value : int) -> void:
	stage = value
	
	_stage = load("res://src/scenes/level/stages/"\
			+ get_stage_name(value).to_lower() + ".gd").new()
	
	sky.texture = _stage.get_sky_texture()
	clouds.texture = _stage.get_clouds_texture()
	ocean_top.texture = _stage.get_ocean_texture()
	ocean_bottom.texture = _stage.get_ocean_texture()
	waves_front.texture = _stage.get_waves_texture()
	waves_back.texture = _stage.get_waves_texture()
	
	for child in objects.get_children():
		objects.remove_child(child)
		child.queue_free()
	
	_stage.random(objects)
	wall_left.wall_points = _stage.get_wall_points()
	wall_right.wall_points = _stage.get_wall_points()
	level_floor.position.y = _stage.get_stage_depth() * 16 + 270
	hud.update_depth_max(_stage.get_stage_depth())


func get_stage_name(value : int) -> String:
	return Stages.keys()[stage]


func stage_name_to_enum(value : String) -> int:
	match value:
		"Coast":
			return Stages.COAST
		"Bay":
			return Stages.BAY
		"ShallowWaters":
			return Stages.SHALLOW_WATERS
		"Ocean":
			return Stages.OCEAN
		"TheDeep":
			return Stages.THE_DEEP
	return Stages.COAST


func start_resting() -> void:
	if not is_instance_valid(hud):
		return
	
	hud.start_resting()


## Private Methods
func _set_depth(depth : float) -> void:
	_depth = clamp(
			depth, 0, _stage.get_stage_depth() if is_instance_valid(_stage) else INF)


func _cast() -> void:
	_game_state = GameStates.CASTING
	animation_player.play("Cast")
	yield(animation_player, "animation_finished")
	_game_state = GameStates.FISHING
	_set_depth(0.0)


func _start_reeling() -> void:
	if not _game_state == GameStates.FISHING:
		return
	
	_game_state = GameStates.START_REELING
	animation_player.play("HookHit")
	yield(animation_player, "animation_finished")
	_game_state = GameStates.REELING


func _stop_reeling() -> void:
	_game_state = GameStates.STOP_REELING
	animation_player.play("Reel")
	yield(animation_player, "animation_finished")
	_game_state = GameStates.IDLE
	Session.money += hook.liquidate()
	hud.update_money()
	_set_depth(0.0)


func _on_Hook_hit():
	if _game_state == GameStates.REELING:
		hook.liquidate()
		_stop_reeling()
	else:
		_start_reeling()


func _on_HUD_resting():
	_resting = true
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	set_stage(stage)
	hud.stop_resting()
	_resting = false
