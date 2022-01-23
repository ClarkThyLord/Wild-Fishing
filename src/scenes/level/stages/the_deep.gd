extends Stage
## Level The Deep Stage Class



## Private Variables
var _fish_0 := [
	10,
	11,
	12,
	13,
	21,
	22,
	23,
	24,
	25,
	26,
	27,
	28,
	29,
	30,
	31,
	32,
	33,
	34,
	51,
]

var _fish_1 := [
	57,
	58,
	59,
	60,
	61,
	62,
	63,
	64,
	65,
	66,
	67,
	68,
	69,
	70,
]

var _fish_2 := [
	88,
	88,
	89,
	89,
	85,
	85,
	86,
	86,
	87,
	87,
]

var _fish_3 := [
	71,
	71,
	71,
	72,
	72,
	72,
	73,
	73,
	73,
	74,
	74,
	74,
	75,
	75,
	75,
]

var _fish_4 := [
	76,
	77,
	78,
	52,
	53,
	54,
	55,
	56,
]

var _fish_5 := [
	79,
	80,
	81,
	82,
	83,
	84,
]



## Built-In Virtual Methods
func _init() -> void:
	_stage_depth = 3000
	
	_ocean = preload("res://assets/scenes/level/stages/the_deep/ocean.png")
	_waves = preload("res://assets/scenes/level/stages/the_deep/waves.png")
	_clouds = preload("res://assets/scenes/level/stages/the_deep/clouds.png")
	_sky = preload("res://assets/scenes/level/stages/the_deep/sky.png")



## Public Methods
func random(objects : Node2D) -> void:
	_wall_points.clear()
	
	var stage_end := min(_stage_depth, Session.get_line_used().get_length())
	
	for s in range(stage_end + 42):
		_wall_points.append(1)
	
	var objs := 0
	
	var fishes := _fish_0.duplicate()
	
	var fish_1 := true
	var fish_2 := true
	var fish_3 := true
	var fish_4 := true
	var fish_5 := true
	
	var y := 375.0
	while y < stage_end * 16:
		if randf() < 0.6 and objs < 60:
			continue
		
		if fish_1 and y / 16 > 500:
			fish_1 = false
			fishes += _fish_1
		elif fish_2 and y / 16 > 1000:
			fish_2 = false
			for fish in _fish_0:
				fishes.erase(fish)
			fishes += _fish_2
		elif fish_3 and y / 16 > 1500:
			fish_3 = false
			for fish in _fish_1:
				fishes.erase(fish)
			fishes += _fish_3
		elif fish_4 and y / 16 > 2000:
			fish_4 = false
			fishes += _fish_4
		elif fish_5 and y / 16 > 2500:
			fish_5 = false
			for fish in _fish_2:
				fishes.erase(fish)
			fishes += _fish_5
		
		var obj : LevelObject
		
		obj = preload("res://src/scenes/level/objects/fish/fish.tscn").instance()
		obj.fish = fishes[randi() % fishes.size()]
		
		objects.add_child(obj)
		
		obj.random()
		
		y += (obj.get_height() * 2) + (randf() * 100)
		obj.position.y = y
		
		objs += 1
	
	_fish_count = objs
