extends StaticBody2D

var isOn

func _ready():
	get_node("IdleSprite").hide()
	get_node("AnimatedSprite").show()
	isOn = true
	set_fixed_process(true)

func _fixed_process(delta):
	pass

func shutdown():
	get_node("IdleSprite").show()
	get_node("AnimatedSprite").hide()
	isOn = false
	
func turnOn():
	get_node("IdleSprite").show()
	get_node("AnimatedSprite").hide()
	isOn = true

func _on_O2Generator_input_event( viewport, event, shape_idx ):
	if ((event.type == InputEvent.MOUSE_BUTTON) and (event.pressed == true)):
		get_node("../../Character").move(0, get_global_pos().x)
