extends CanvasLayer
## Level HUD Class



# OnReady Variables
onready var money : Label = get_node("InfoPanel/Money")

onready var depth : Label = get_node("InfoPanel/Depth")

onready var depth_max : Label = get_node("InfoPanel/DepthMax")

onready var settings : Button = get_node("InfoPanel/Settings")



## Public Methods
func update_money(value : float = Session.money) -> void:
	if not is_instance_valid(money):
		return
	
	money.text = "$     %07d" % value


func update_depth(value : float) -> void:
	if not is_instance_valid(depth):
		return
	
	depth.text = "%.2f ft." % value

func update_depth_max(value : float) -> void:
	if not is_instance_valid(depth_max):
		return
	
	depth_max.text = "%d ft." % value



## Private Methods
func _on_Settings_pressed():
	Settings.show()
