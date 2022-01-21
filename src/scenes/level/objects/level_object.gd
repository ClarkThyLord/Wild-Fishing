extends Area2D
class_name LevelObject
## Level Object Class



## Enums
enum ObjectStates {
	IDLE,
	MOVING_LEFT,
	MOVING_RIGHT,
	CAUGHT,
}



## Exported Variables
export(ObjectStates) var object_state := ObjectStates.IDLE

export var speed := 16.0 setget set_speed

export var sprite : NodePath

export var collision_polygon : NodePath



## Private Variables
var _sprite : Sprite

var _collision_polygon : CollisionPolygon2D



## Built-In Virtual Methods
func _ready() -> void:
	if object_state == ObjectStates.MOVING_LEFT:
		position.x  = -80
	elif object_state == ObjectStates.MOVING_RIGHT:
		position.x = 1104


func _process(delta : float) -> void:
	var direction := Vector2.ZERO
	match object_state:
		ObjectStates.MOVING_LEFT:
			direction = Vector2.LEFT
		ObjectStates.MOVING_RIGHT:
			direction = Vector2.RIGHT
	
	position += speed * direction
	
	if object_state == ObjectStates.MOVING_LEFT\
			and position.x < -80:
		set_object_state(ObjectStates.MOVING_RIGHT)
	elif object_state == ObjectStates.MOVING_RIGHT\
			and position.x > 1104:
		set_object_state(ObjectStates.MOVING_LEFT)



## Public Methods
func set_object_state(value : int) -> void:
	object_state = value
	
	scale = scale.abs()
	if object_state == ObjectStates.MOVING_LEFT:
		scale.x *= -1


func set_speed(value : float) -> void:
	speed = clamp(value, 3, 12)


func set_sprite(value : NodePath) -> void:
	sprite = value
	_sprite = get_node_or_null(sprite)
	
	update_collision_polygon()


func set_collision_polygon(value : NodePath) -> void:
	collision_polygon = value
	_collision_polygon = get_node_or_null(collision_polygon)
	
	update_collision_polygon()


func random() -> void:
	set_object_state(
			ObjectStates.MOVING_LEFT if randf() <= 0.5 else ObjectStates.MOVING_RIGHT)


func get_width() -> float:
	return _sprite.texture.get_width() * scale.x


func get_height() -> float:
	return _sprite.texture.get_height() * scale.y


func liquidate() -> int:
	return 0


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
