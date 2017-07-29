extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

func _on_EnergyRack_input_event( viewport, event, shape_idx ):
	if ((event.type == InputEvent.MOUSE_BUTTON) and (event.pressed == true)):
		get_node("../../Character").move(0, get_global_pos().x)


func _on_EnergyRack1_input_event( viewport, event, shape_idx ):
	pass # replace with function body
