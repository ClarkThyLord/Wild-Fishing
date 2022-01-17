extends Area2D
## Level Object Class


## Enums
enum Directions {
	LEFT = -1,
	RIGHT = 1,
}



## Exported Variables
export var speed := 16

export var direction := Directions.LEFT

export var sprite : NodePath

export var collision_polygon : NodePath


## Private Variables
var _sprite : Sprite

var _collision_polygon : CollisionPolygon2D



## Built-In Virtual Methods
func _process(delta : float) -> void:
	position.x += speed * direction
	if direction == Directions.LEFT and position.x < -80:
		set_direction(Directions.RIGHT)
	elif direction == Directions.RIGHT and position.x > 1104:
		set_direction(Directions.LEFT)



## Public Methods
func set_direction(value : int) -> void:
	direction = value
	if is_instance_valid(_sprite):
		if direction == Directions.LEFT:
			scale.x = abs(scale.x) * -1
		else:
			scale.x = abs(scale.x)


func set_sprite(value : NodePath) -> void:
	sprite = value
	_sprite = get_node_or_null(sprite)
	
	update_collision_polygon()


func set_collision_polygon(value : NodePath) -> void:
	collision_polygon = value
	_collision_polygon = get_node_or_null(collision_polygon)
	
	update_collision_polygon()


func update_collision_polygon() -> void:
	if not is_instance_valid(_sprite)\
			or not is_instance_valid(_sprite.texture)\
			or not is_instance_valid(_collision_polygon):
		return
	
	var bm = BitMap.new()
	bm.create_from_image_alpha(_sprite.texture.get_data())
	var points = bm.opaque_to_polygons(
		Rect2(
			0,
			0,
			_sprite.texture.get_width(),
			_sprite.texture.get_height()
		)
	)
	if points.size() > 0:
		_collision_polygon.set_polygon(points[0])
		_collision_polygon.position.x = -_sprite.texture.get_width() / 2
		_collision_polygon.position.y = -_sprite.texture.get_height() / 2
