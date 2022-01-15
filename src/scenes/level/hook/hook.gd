extends Area2D
## Level Hook Class



## Exported Variable
export(float, 0.0, 1_000.0) var speed := 300.0



## Built-In Virtual Methods
func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")


func _process(delta : float) -> void:
	var direction := Vector2.ZERO
	
	if Input.is_action_pressed("game_move_left"):
		direction += Vector2.LEFT
	if Input.is_action_pressed("game_move_right"):
		direction += Vector2.RIGHT
	
	position += (direction * speed) * delta



## Private Methods
func _on_body_entered(body : PhysicsBody2D) -> void:
	print(body)
