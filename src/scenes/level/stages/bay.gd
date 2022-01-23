extends Stage
## Level Bay Stage Class



## Private Variables
var _fish_0 := [
	6,
	7,
	8,
	9,
	14,
	15,
	35,
	38,
	39,
	40,
	41,
	44,
	45,
]

var _fish_1 := [
	0,
	1,
	2,
	3,
	4,
	5,
	36,
	37,
	46,
	47,
]

var _fish_2 := [
	10,
	11,
	12,
	48,
	49,
	50,
]

var _fish_3 := [
	13,
	13,
	16,
	17,
	18,
	19,
	20
]

var _fish_4 := [
	21,
	22,
	23,
	24,
	25,
	30,
	33,
	34
]



## Built-In Virtual Methods
func _init() -> void:
	_stage_depth = 800
	
	_ocean = preload("res://assets/scenes/level/stages/bay/ocean.png")
	_waves = preload("res://assets/scenes/level/stages/bay/waves.png")
	_clouds = preload("res://assets/scenes/level/stages/bay/clouds.png")
	_sky = preload("res://assets/scenes/level/stages/bay/sky.png")



## Public Methods
func random(objects : Node2D) -> void:
	_wall_points.clear()
	for s in range(_stage_depth + 32):
		var h = (cos(pow(s, 1.25)) + 1.5) * 2
		print(h)
		_wall_points.append(h + 1 + randi() % 4)
	
	var objs := 0
	
	var fishes := _fish_0.duplicate()
	
	var fish_1 := false
	var fish_2 := false
	var fish_3 := false
	var fish_4 := false
	
	var y := 375.0
	while y < _stage_depth * 16:
		if randf() < 0.6 and objs < 60:
			continue
		
		if fish_1 and y / 16 > 200:
			fish_1 = false
			fishes += _fish_1
		elif fish_2 and y / 16 > 350:
			fish_2 = false
			for fish in _fish_0:
				fishes.erase(fish)
			fishes += _fish_2
		elif fish_3 and y / 16 > 500:
			fish_3 = false
			for fish in _fish_1:
				fishes.erase(fish)
			fishes += _fish_3
		elif fish_4 and y / 16 > 600:
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
