extends Node2D
## Level Class



## Enums
enum Stages {
	BAY,
}

enum GameStates {
	IDLE,
	CASTING,
	FISHING,
	STOPPING,
	REELING,
	STOP_REELING,
}



## Exported Variables
export(Stages) var stage = Stages.BAY setget set_stage



## Private Variables
var _game_state : int = GameStates.IDLE

var _depth := 0.0

var _depth_max : int

var _wall_step_px : int

var _wall_height_min : int

var _wall_height_max : int



## OnReady Variables
onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")

onready var hook := get_node("Hook")

onready var objects : Node2D = get_node("Objects")

onready var walls : Node2D = get_node("Walls")

onready var wall_left := get_node("Walls/WallLeft")

onready var wall_right := get_node("Walls/WallRight")



## Built-In Virtual Methods
func _ready() -> void:
	randomize()
	
	set_stage(stage)


func _process(delta : float) -> void:
	# CAST
	if _game_state == GameStates.IDLE\
			and Input.is_action_just_released("game_start"):
		_game_state = GameStates.CASTING
		animation_player.play("Cast")
		yield(animation_player, "animation_finished")
		_game_state = GameStates.FISHING
		_set_depth(0.0)
	
	# STOP
	if _game_state == GameStates.REELING and _depth <= 0.0:
		_game_state = GameStates.STOP_REELING
		animation_player.play("Reel")
		yield(animation_player, "animation_finished")
		_game_state = GameStates.IDLE
		_set_depth(0.0)
	
	# Increase / Decrease depth
	var playing := false
	var plunging_speed := 25
	if _game_state == GameStates.FISHING:
		_set_depth(_depth + plunging_speed * delta)
		playing = true
	elif _game_state == GameStates.REELING:
		_set_depth(_depth + -plunging_speed * delta)
		playing = true
	elif _game_state == GameStates.STOPPING:
		_set_depth(_depth + -plunging_speed * delta)
	
	hook.playing = playing
	wall_left.step = _depth
	wall_right.step = _depth



## Public Methods
func set_stage(value : int) -> void:
	stage = value
	
	_wall_step_px = 16
	match stage:
		Stages.BAY:
			_depth_max = 1000
			_wall_height_min = 1
			_wall_height_max = 4
	
	_generate_level()



## Private Methods
func _set_depth(depth : float) -> void:
	_depth = clamp(depth, 0, INF)


func _generate_level() -> void:
	var steps = []
	for s in range(_depth_max):
		steps.append(_wall_height_min + randi() % _wall_height_max)
	wall_left.steps = steps
	wall_right.steps = steps


func _start_reeling() -> void:
	if not _game_state == GameStates.FISHING:
		return
	
	_game_state = GameStates.STOPPING
	animation_player.play("Stop")
	yield(animation_player, "animation_finished")
	_game_state = GameStates.REELING


func _on_Hook_hit():
	_start_reeling()
