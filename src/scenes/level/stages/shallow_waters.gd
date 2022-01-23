extends Stage
## Level Shallow Waters Stage Class



## Private Variables
var _fish_0 := [
	0,
	1,
	2,
	3,
	4,
	5,
	10,
	11,
	12,
]

var _fish_1 := [
	13,
	21,
	22,
	23,
	24,
	25,
]

var _fish_2 := [
	30,
	31,
	32,
	33,
	34,
	51,
	57,
	58,
	59,
	60,
	61,
	62,
]

var _fish_3 := [
	63,
	63,
	64,
	64,
	65,
	65,
]

var _fish_4 := [
	17,
	18,
	19,
	20
]



## Built-In Virtual Methods
func _init() -> void:
	_stage_depth = 1000
	
	_ocean = preload("res://assets/scenes/level/stages/shallow_waters/ocean.png")
	_waves = preload("res://assets/scenes/level/stages/shallow_waters/waves.png")
	_clouds = preload("res://assets/scenes/level/stages/shallow_waters/clouds.png")
	_sky = preload("res://assets/scenes/level/stages/shallow_waters/sky.png")



## Public Methods
func random(objects : Node2D) -> void:
	_wall_points.clear()
	
	var stage_end := min(_stage_depth, Session.get_line_used().get_length())
	for s in range(int((stage_end + 42 / 6))):
		var h = (cos(s / 3) + 1) * 2 + randi() % 4
		for i in range(6):
			_wall_points.append(h + 2)
	
	var objs := 0
	
	var fishes := _fish_0.duplicate()
	
	var fish_1 := true
	var fish_2 := true
	var fish_3 := true
	var fish_4 := true
	
	var y := 375.0
	while y < stage_end * 16:
		if randf() < 0.6 and objs < 60:
			continue
		
		if fish_1 and y / 16 > 200:
			fish_1 = false
			fishes += _fish_1
		elif fish_2 and y / 16 > 400:
			fish_2 = false
			for fish in _fish_0:
				fishes.erase(fish)
			fishes += _fish_2
		elif fish_3 and y / 16 > 650:
			fish_3 = false
			for fish in _fish_1:
				fishes.erase(fish)
			fishes += _fish_3
		elif fish_4 and y / 16 > 800:
			fish_4 = false
			fishes += _fish_4
		
		var obj : LevelObject
		
		obj = preload("res://src/scenes/level/objects/fish/fish.tscn").instance()
		obj.fish = fishes[randi() % fishes.size()]
		
		objects.add_child(obj)
		
		obj.random()
		
		y += (obj.get_height() * 2) + (randf() * 100)
		obj.position.y = y
		
		objs += 1
	
	_fish_count = objs
