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
]

var _fish_1 := [
	0,
	1,
	2,
	3,
	4,
	5,
]

var _fish_2 := [
	10,
	11,
	12,
]

var _fish_3 := [
	13,
	13,
]



## Built-In Virtual Methods
func _init() -> void:
	_stage_depth = 500
	
	_ocean = preload("res://assets/scenes/level/stages/the_deep/ocean.png")
	_waves = preload("res://assets/scenes/level/stages/the_deep/waves.png")
	_clouds = preload("res://assets/scenes/level/stages/the_deep/clouds.png")
	_sky = preload("res://assets/scenes/level/stages/the_deep/sky.png")



## Public Methods
func random(objects : Node2D) -> void:
	_wall_points.clear()
	for s in range(_stage_depth + 32):
		var h = (cos(s / 3) + 1) * 2
		_wall_points.append(h + 1 + randi() % 4)
	
	var objs := 0
	
	var fishes := _fish_0.duplicate()
	
	var y := 375.0
	while y < _stage_depth * 16:
		if randf() < 0.6 and objs < 60:
			continue
		
		if y / 16 > 150:
			fishes += _fish_1
		elif y / 16 > 300:
			for fish in _fish_0:
				fishes.erase(fish)
			fishes += _fish_2
		elif y / 16 > 400:
			fishes += _fish_3
		
		var obj : LevelObject
		
		obj = preload("res://src/scenes/level/objects/fish/fish.tscn").instance()
		obj.fish = fishes[randi() % fishes.size()]
		
		objects.add_child(obj)
		
		obj.random()
		
		y += (obj.get_height() * 2) + (randf() * 100)
		obj.position.y = y
		
		objs += 1
