extends StaticBody2D

var isOn

func _ready():
	get_node("SpriteOff").hide()
	get_node("SpriteOn").show()
	isOn = true
	set_fixed_process(true)

func _fixed_process(delta):
	pass

func shutdown():
	get_node("SpriteOff").show()
	get_node("SpriteOn").hide()
	isOn = false
	
func turnOn():
	get_node("SpriteOn").show()
	get_node("SpriteOff").hide()
	isOn = true

func _on_Heater_input_event( viewport, event, shape_idx ):
	if ((event.type == InputEvent.MOUSE_BUTTON) and (event.pressed == true)):
		get_node("../../Character").move(0, get_global_pos().x)