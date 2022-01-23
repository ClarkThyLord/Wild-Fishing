extends Node2D
## Level Hook Class



## Signals
signal hit



## Enums
enum HookStates {
	IDLE,
	PLUNGING,
	RISING,
}



## Exported Variable
export(HookStates) var hook_state : int = HookStates.IDLE

export(float, 0.0, 1_000.0) var speed := 16.0



## OnReady Variables
onready var animation_player : AnimationPlayer = get_node("Area2D/AnimationPlayer")

onready var sprite : Sprite = get_node("Area2D/Sprite")

onready var collision_polygon : CollisionPolygon2D = get_node("Area2D/CollisionPolygon2D")



## Built-In Virtual Methods
func _ready() -> void:
	var hook_item : HookItem = Session.get_hook_used()
	sprite.texture = hook_item.get_texture()
	speed = hook_item.get_strafing_speed()
	
	var bm = BitMap.new()
	bm.create_from_image_alpha(sprite.texture.get_data())
	var points = bm.opaque_to_polygons(
		Rect2(
			0,
			0,
			sprite.texture.get_width(),
			sprite.texture.get_height()
		)
	)
	if points.size() > 0:
		collision_polygon.set_polygon(points[0])


func _process(delta : float) -> void:
	if hook_state == HookStates.IDLE:
		return
	
	var direction := Vector2.ZERO
	
	if Input.is_action_pressed("game_move_left"):
		direction += Vector2.LEFT
	if Input.is_action_pressed("game_move_right"):
		direction += Vector2.RIGHT
	
	position += (direction * speed)



## Public Methods
func liquidate() -> int:
	var revenue := 0
	
	for node in get_children():
		if node is LevelObject:
			revenue += node.liquidate()
	
	return revenue



## Private Methods
func _on_Area2D_area_entered(area : Area2D) -> void:
	if area.is_in_group("fishes"):
		area.hooked_by(self)
	
	if area.is_in_group("obstacles") and hook_state == HookStates.PLUNGING\
			or not area.is_in_group("fishes"):
		animation_player.play("Hit")
		emit_signal("hit")
