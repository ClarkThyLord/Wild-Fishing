extends CanvasLayer
## Level HUD



## Signals
signal resting



## Private Variables
var _depth := 0.0



# OnReady Variables
onready var resting : ColorRect = get_node("Rest")

onready var map : Button = get_node("Options/HBoxContainer/Map")

onready var rest : Button = get_node("Options/HBoxContainer/Rest")

onready var money : Label = get_node("InfoPanel/Money")

onready var depth : Label = get_node("InfoPanel/Depth")

onready var depth_max : Label = get_node("InfoPanel/DepthMax")

onready var settings : Button = get_node("InfoPanel/Settings")




## Built-In Virtual Methods
func _ready() -> void:
	resting.visible = false



## Public Methods
func update_money(value : float = Session.money) -> void:
	if not is_instance_valid(money):
		return
	
	money.text = "$     %07d" % value


func update_depth(value : float) -> void:
	_depth = value
	
	if is_instance_valid(map):
		map.disabled = _depth > 0.0
	
	if is_instance_valid(rest):
		rest.disabled = _depth > 0.0
	
	if is_instance_valid(depth):
		depth.text = "%.2f ft." % value


func update_depth_max(value : float) -> void:
	if not is_instance_valid(depth_max):
		return
	
	depth_max.text = "%d ft." % value


func start_resting() -> void:
	resting.visible = true
	rest.release_focus()
	rest.disabled = true
	
	emit_signal("resting")


func stop_resting() -> void:
	rest.disabled
	resting.visible = false



## Private Methods
func _on_Map_pressed():
	Session.open_map()


func _on_Rest_pressed():
	if _depth > 0.0:
		return
	
	start_resting()


func _on_Settings_pressed():
	Settings.show()
