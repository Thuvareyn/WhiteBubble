extends StaticBody2D

var isOn = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if isOn:
		get_node("../Battery4").consume(delta*10/6)


func _on_Interruptor4_input_event( viewport, event, shape_idx ):
	if ((event.type == InputEvent.MOUSE_BUTTON) and (event.pressed == true)):
		get_node("../../../Character").move(0, get_global_pos().x)
		if isOn:
			turnOff()
		else:
			turnOn()

func turnOn():
	get_node("AnimatedSprite").set_frame(1)
	isOn = true
	
func turnOff():
	get_node("AnimatedSprite").set_frame(0)
	isOn = false