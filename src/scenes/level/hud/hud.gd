extends CanvasLayer
## Level HUD Class



# OnReady Variables
onready var hud : Control = get_node("Control")

onready var depth : Label = get_node("Control/Depth")


## Public Methods
func update_depth(value : float) -> void:
	if not is_instance_valid(depth):
		return
	
	depth.text = "DEPTH: %010.2f ft." % value
