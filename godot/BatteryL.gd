extends Node2D

var energy_tot = 100
var destroyed = false
var consumption = 0

func add_comsuption(cons):
	consumption += cons

func is_destroyed():
	return destroyed

func _ready():
	get_node("BatteryAnimation").set_frame(11)
	set_fixed_process(true)

func _fixed_process(delta):
	if !destroyed:
		consume(consumption*delta)

func consume(energy):
	energy_tot -= energy
	if energy_tot == 100:
		get_node("BatteryAnimation").set_frame(11)
	elif energy_tot < 100 && energy_tot >= 90:
		get_node("BatteryAnimation").set_frame(10)
	elif energy_tot < 90 && energy_tot >= 80:
		get_node("BatteryAnimation").set_frame(9)
	elif energy_tot < 80 && energy_tot >= 70:
		get_node("BatteryAnimation").set_frame(8)
	elif energy_tot < 70 && energy_tot >= 60:
		get_node("BatteryAnimation").set_frame(7)
	elif energy_tot < 60 && energy_tot >= 50:
		get_node("BatteryAnimation").set_frame(6)
	elif energy_tot < 50 && energy_tot >= 40:
		get_node("BatteryAnimation").set_frame(5)
	elif energy_tot < 40 && energy_tot >= 30:
		get_node("BatteryAnimation").set_frame(4)
	elif energy_tot < 30 && energy_tot >= 20:
		get_node("BatteryAnimation").set_frame(3)
	elif energy_tot < 20 && energy_tot >= 10:
		get_node("BatteryAnimation").set_frame(2)
	elif energy_tot < 10 && energy_tot >= 0:
		get_node("BatteryAnimation").set_frame(1)
	elif energy_tot < 0 && energy_tot > -10:
		energy_tot = -11
		get_node("BatteryAnimation").set_frame(0)
		get_node("BatteryAnimation").hide()
		get_node("../Interruptor2").turnOff()
		get_node("AnimationPlayer").play("Explosion")
		destroyed = true
	elif destroyed && !get_node("AnimationPlayer").is_playing():
		energy_tot = 50
		hide()