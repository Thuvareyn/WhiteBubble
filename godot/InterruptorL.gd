extends StaticBody2D

var cons = 10/6
var isOn = false

func _ready():
	turnOn()
	set_fixed_process(true)

func _fixed_process(delta):
	pass


func _on_Interruptor2_input_event( viewport, event, shape_idx ):
	if ((event.type == InputEvent.MOUSE_BUTTON) and (event.pressed == true)):
		get_node("../../../Character").move(0, get_global_pos().x)
		if !get_node("../Battery2").is_destroyed():
			if isOn:
				turnOff()
			else:
				turnOn()

func turnOn():
	get_node("../Battery2").add_comsuption(cons)
	get_node("../../Light").show()
	get_node("../../Darkness").hide()
	get_node("AnimatedSprite").set_frame(1)
	isOn = true
	
func turnOff():
	get_node("../Battery2").add_comsuption(-cons)
	get_node("../../Light").hide()
	get_node("../../Darkness").show()
	get_node("AnimatedSprite").set_frame(0)
	isOn = false