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
	START_REELING,
	REELING,
	STOP_REELING,
}



## Exported Variables
export(Stages) var stage = Stages.BAY setget set_stage



## Private Variables
var _game_state : int = GameStates.IDLE

var _depth := 0.0

var _depth_max : int

var _wall_pixel_size : int

var _wall_point_min : int

var _wall_point_max : int



## OnReady Variables
onready var animation_player := get_node("AnimationPlayer")

onready var camera := get_node("Camera2D")

onready var hook := get_node("Camera2D/Hook")

onready var objects : Node2D = get_node("Objects")

onready var walls : Node2D = get_node("Walls")

onready var wall_left := get_node("Walls/WallLeft")

onready var wall_right := get_node("Walls/WallRight")

onready var hud := get_node("HUD")



## Built-In Virtual Methods
func _ready() -> void:
	randomize()
	
	set_stage(stage)


func _process(delta : float) -> void:
	if Input.is_action_just_released("game_start"):
		if _game_state == GameStates.IDLE:
			_cast()
		elif _game_state == GameStates.FISHING:
			_start_reeling()
	
	if _game_state == GameStates.REELING and _depth <= 0.0:
		_stop_reeling()
	
	var playing := false
	var plunging_speed := 50
	if _game_state == GameStates.FISHING:
		_set_depth(_depth + plunging_speed * delta)
		playing = true
	elif _game_state == GameStates.REELING\
			or _game_state == GameStates.START_REELING:
		_set_depth(_depth + -plunging_speed * delta)
		playing = true
	elif _game_state == GameStates.START_REELING:
		_set_depth(_depth + -plunging_speed * delta)
	
	hook.playing = playing
	if playing:
		if _depth < _depth_max - (300 / _wall_pixel_size):
			camera.position.y = 300 + _depth * _wall_pixel_size
		else:
			hook.position.y = clamp(hook.position.y + _wall_pixel_size, -INF, 200)
			if _game_state == GameStates.FISHING and hook.position.y >= 200:
				_game_state = GameStates.REELING
	
	hud.update_depth(_depth)



## Public Methods
func set_stage(value : int) -> void:
	stage = value
	
	_wall_pixel_size = 16
	match stage:
		Stages.BAY:
			_depth_max = 1000
			_wall_point_min = 1
			_wall_point_max = 4
	
	_generate_level()



## Private Methods
func _set_depth(depth : float) -> void:
	_depth = clamp(depth, 0, _depth_max)


func _generate_level() -> void:
	var points = []
	
	for s in range(_depth_max + 32):
		var h = (cos(s / 3) + 1) * 2
		points.append(h + _wall_point_min + randi() % _wall_point_max)
	
	wall_left.wall_points = points
	wall_right.wall_points = points


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
	_set_depth(0.0)


func _on_Hook_hit():
	if _game_state == GameStates.REELING:
		_stop_reeling()
	else:
		_start_reeling()
