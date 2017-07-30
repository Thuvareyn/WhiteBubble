extends StaticBody2D

var cons = 10/6
var isOn = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	pass


func _on_Interruptor4_input_event( viewport, event, shape_idx ):
	if ((event.type == InputEvent.MOUSE_BUTTON) and (event.pressed == true)):
		get_node("../../../Character").move(0, get_global_pos().x)
		if !get_node("../Battery4").is_destroyed():
			if isOn:
				turnOff()
			else:
				turnOn()

func turnOn():
	get_node("AnimatedSprite").set_frame(1)
	get_node("../Battery4").add_comsuption(cons)
	isOn = true
	
func turnOff():
	get_node("AnimatedSprite").set_frame(0)
	get_node("../Battery4").add_comsuption(-cons)
	isOn = false