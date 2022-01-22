tool
extends HBoxContainer
## H Labeled Slider Class



## Exported Variables
export var text := "" setget set_text

export var min_value := 0.0 setget set_min_value

export var max_value := 100.0 setget set_max_value

export var step := 1.0 setget set_step

export var value := 0.0 setget set_value



## OnReady Variables
onready var label : Label = get_node("Label")

onready var h_slider : HSlider = get_node("HSlider")



## Built-In Virtual Methods
func _ready() -> void:
	set_text(text)
	set_min_value(min_value)
	set_max_value(max_value)
	set_step(step)
	set_value(value)



## Public Methods
func set_text(value : String) -> void:
	text = value
	
	if is_instance_valid(label):
		label.text = text


func set_min_value(value : float) -> void:
	min_value = value
	
	if is_instance_valid(h_slider):
		h_slider.min_value = min_value


func set_max_value(value : float) -> void:
	max_value = value
	
	if is_instance_valid(h_slider):
		h_slider.max_value = max_value


func set_step(value : float) -> void:
	step = value
	
	if is_instance_valid(h_slider):
		h_slider.step = step


func set_value(new_value : float) -> void:
	value = new_value
	
	if is_instance_valid(h_slider):
		h_slider.value = value

