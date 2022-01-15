extends Node2D
## Level Class



## Enums
enum Stages {
	BAY,
}



## Exported Variables
export(Stages) var stage = Stages.BAY setget set_stage



## Private Variables
var _depth := -1.0

var _depth_max : int

var _wall_step_px : int

var _wall_height_min : int

var _wall_height_max : int



## OnReady Variables
onready var objects : Node2D = get_node("Objects")

onready var walls : Node2D = get_node("Walls")

onready var wall_left : Polygon2D = get_node("Walls/WallLeft")

onready var wall_right : Polygon2D = get_node("Walls/WallRight")



## Built-In Virtual Methods
func _ready() -> void:
	randomize()
	
	set_stage(stage)


func _process(delta : float) -> void:
	wall_left.step += 6 * delta
	wall_right.step += 6 * delta



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
func _generate_level() -> void:
	var steps = []
	for s in range(_depth_max):
		steps.append(_wall_height_min + randi() % _wall_height_max)
	wall_left.steps = steps
	wall_right.steps = steps
