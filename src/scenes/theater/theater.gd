extends CanvasLayer
## Theater Scene



## Exported Variables
export(int, 0, 100) var slide := 0



## Private Variables
var _slides : Array



## OnReady Variables
onready var control : Control = get_node("Control")

onready var slide_texture : TextureRect

onready var prev : Button = get_node("Control/Prev")

onready var next : Button = get_node("Control/Next")



## Built-In Virtual Methods
func _ready() -> void:
	hide()



## Public Methods
func show(slides : Array, slide := 0) -> void:
	_slides = slides
	self.slide = slide
	
	control.show()


func hide() -> void:
	control.hide()


func set_slide(value : int) -> void:
	if value < 0 and value > _slides.size():
		return
	
	slide = value
	
	if is_instance_valid(slide_texture):
		slide_texture.texture = _slides[slide]
	
	if is_instance_valid(prev):
		prev.visible = slide > 0
	
	if is_instance_valid(next):
		next.visible = slide < _slides.size() - 1



## Private Methods
func _on_Prev_pressed():
	if slide <= 0:
		return
	
	self.slide -= 1


func _on_Next_pressed():
	if slide >= _slides.size():
		return
	
	self.slide += 1
