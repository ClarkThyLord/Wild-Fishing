extends Area2D
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



## Private Variables
var _tween := Tween.new()



## OnReady Variables
onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")



## Built-In Virtual Methods
func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")


func _process(delta : float) -> void:
	if hook_state == HookStates.IDLE:
		return
	
	var direction := Vector2.ZERO
	
	if Input.is_action_pressed("game_move_left"):
		direction += Vector2.LEFT
	if Input.is_action_pressed("game_move_right"):
		direction += Vector2.RIGHT
	
	position += (direction * speed)



## Private Methods
func _on_area_entered(area : Area2D) -> void:
	if area.is_in_group("fishes"):
		area.hook_by(self)
	
	if area.is_in_group("obstacles") and hook_state == HookStates.PLUNGING\
			or not area.is_in_group("fishes"):
		animation_player.play("Hit")
		emit_signal("hit")
