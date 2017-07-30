extends KinematicBody2D

const SPEED = 150
var targetFloor = 2
var targetX = get_pos().x
var left = false
var right = false
var actualFloor = 2
var takingStairs = false
var up = false

var food_lvl = 70
var energy_lvl = 70
var food_cons = 10/6
var energy_cons = 10/6

var max_timer_humor = 3
var timer_humor_energy = -1
var timer_humor_food = -1

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if timer_humor_food != -1:
		timer_humor_food += delta
	if timer_humor_energy != -1:
		timer_humor_energy += delta
	if timer_humor_food >= max_timer_humor:
		hide_humor(1)
	if timer_humor_energy >= max_timer_humor:
		hide_humor(2)
	
	var prev_food = fmod(food_lvl, 10)
	var prev_energy = fmod(energy_lvl,10)
	food_lvl -= delta*food_cons
	energy_lvl -= delta*energy_cons
	if prev_food < fmod(food_lvl,10):
		display_humor(1)
	if prev_energy < fmod(energy_lvl,10):
		display_humor(2)
	
	if takingStairs:
		set_z(2)
	else:
		set_z(3)

	var direction = Vector2()
	if targetFloor == actualFloor && !takingStairs:
		if targetX < get_global_pos().x && !right:
			get_node("WalkLeft").show()
			if !get_node("Animation").is_playing ( ):
				get_node("Animation").play("WalkLeftAnimation")
			get_node("WalkRight").hide()
			direction.x += -SPEED
			left = true
		elif targetX > get_global_pos().x && !left:
			get_node("WalkRight").show()
			if !get_node("Animation").is_playing ( ):
				get_node("Animation").play("WalkRightAnimation")
			get_node("WalkLeft").hide()
			direction.x += SPEED
			right = true
		else:
			get_node("Animation").stop()
	elif actualFloor == 2 && actualFloor > targetFloor && !takingStairs:
		if get_global_pos().x > get_node("../Back/StairDownFloor2").get_global_pos().x && !right:
			get_node("WalkLeft").show()
			if !get_node("Animation").is_playing ( ):
				get_node("Animation").play("WalkLeftAnimation")
			get_node("WalkRight").hide()
			direction.x += -SPEED
			left = true
		elif get_global_pos().x < get_node("../Back/StairDownFloor2").get_global_pos().x && !left:
			get_node("WalkRight").show()
			if !get_node("Animation").is_playing ( ):
				get_node("Animation").play("WalkRightAnimation")
			get_node("WalkLeft").hide()
			direction.x += SPEED
			right = true
		else:
			takingStairs = true
			right = true
	elif actualFloor == 1 && actualFloor > targetFloor && !takingStairs:
		get_node("WalkLeft").show()
		if !get_node("Animation").is_playing ( ):
			get_node("Animation").play("WalkLeftAnimation")
		get_node("WalkRight").hide()
		direction.x += -SPEED
		left = true
	elif (actualFloor == 0 || actualFloor == 1) && actualFloor < targetFloor && !takingStairs:
		if right:
			get_node("WalkRight").show()
			if !get_node("Animation").is_playing ( ):
				get_node("Animation").play("WalkRightAnimation")
			get_node("WalkLeft").hide()
			direction.x -= -SPEED
			up = true
		else:
			get_node("WalkLeft").show()
			if !get_node("Animation").is_playing ( ):
				get_node("Animation").play("WalkLeftAnimation")
			get_node("WalkRight").hide()
			direction.x += -SPEED
			left = true
			up = true
	elif takingStairs && actualFloor == 2 && up == false:
		if right :
			get_node("WalkRight").show()
			if !get_node("Animation").is_playing ( ):
				get_node("Animation").play("WalkRightAnimation")
			get_node("WalkLeft").hide()
			direction.x += SPEED
			direction.y += SPEED
		elif left :
			get_node("WalkLeft").show()
			if !get_node("Animation").is_playing ( ):
				get_node("Animation").play("WalkLeftAnimation")
			get_node("WalkRight").hide()
			direction.x -= SPEED
			direction.y += SPEED
	elif takingStairs && actualFloor == 1 && up == false:
		if right :
			get_node("WalkRight").show()
			if !get_node("Animation").is_playing ( ):
				get_node("Animation").play("WalkRightAnimation")
			get_node("WalkLeft").hide()
			direction.x += SPEED
			direction.y += SPEED
		elif left :
			get_node("WalkLeft").show()
			if !get_node("Animation").is_playing ( ):
				get_node("Animation").play("WalkLeftAnimation")
			get_node("WalkRight").hide()
			direction.x -= SPEED
			direction.y += SPEED
	elif takingStairs && (actualFloor == 0||actualFloor == 1) && up == true:
		if right :
			get_node("WalkRight").show()
			if !get_node("Animation").is_playing ( ):
				get_node("Animation").play("WalkRightAnimation")
			get_node("WalkLeft").hide()
			direction.x += SPEED
			direction.y -= SPEED
		elif left :
			get_node("WalkLeft").show()
			if !get_node("Animation").is_playing ( ):
				get_node("Animation").play("WalkLeftAnimation")
			get_node("WalkRight").hide()
			direction.x -= SPEED
			direction.y -= SPEED
	else:
		get_node("Animation").stop()
	set_pos(get_pos() + direction.normalized() * SPEED * delta)

func move(f, x):
	if !takingStairs:
		targetFloor = f
		targetX = x
		right = false
		left = false

func _on_Floor15_body_enter( body ):
	right = false
	left = true


func _on_Floor1Up_body_enter( body ):
	if actualFloor == 2:
		left = false
		takingStairs = false
		actualFloor = 1
	elif (actualFloor == 1 && up == true) || targetFloor == 2:
		left = false
		right = true
		takingStairs = true
		up = true


func _on_Floor1Down_body_enter( body ):
	if actualFloor != 0 && !right:
		left = false
		right = true
		takingStairs = true
	else:
		left = false
		right = true
		takingStairs = false
		actualFloor = 1
		up = false


func _on_Floor05_body_enter( body ):
	right = false
	left = true


func _on_Floor0Up_body_enter( body ):
	if actualFloor == 0:
		left = false
		right = true
		takingStairs = true
		up=true
	else:
		left = false
		takingStairs = false
		actualFloor = 0


func _on_Floor2Down_body_enter( body ):
	if actualFloor == 1:
		left = false
		right = true
		takingStairs = false
		up=false
		actualFloor = 2


func _on_Character_input_event( viewport, event, shape_idx ):
	if ((event.type == InputEvent.MOUSE_BUTTON) and (event.pressed == true)):
		display_humor(5)

func display_humor(id):
	var frame = get_humor_frame(food_lvl)
	if id == 1 || id == 5:
		get_node("FoodHumor").show()
		get_node("FoodBack").show()
		if frame == 7:
			get_node("FoodBack").set_frame(1)
		else:
			get_node("FoodBack").set_frame(0)
		get_node("FoodHumor").set_frame(frame)
		timer_humor_food = 0
	if id == 2 || id == 5:
		get_node("EnergyHumor").show()
		get_node("EnergyBack").show()
		if frame == 7:
			get_node("EnergyBack").set_frame(1)
		else:
			get_node("EnergyBack").set_frame(0)
		get_node("EnergyHumor").set_frame(frame)
		timer_humor_energy = 0

func get_humor_frame(lvl):
	if lvl>60:
		return 0
	if lvl>50:
		return 1
	if lvl>40:
		return 2
	if lvl>30:
		return 3
	if lvl>20:
		return 4
	if lvl>10:
		return 5
	if lvl>0:
		return 6
	return 0

func hide_humor(id):
	if id == 1 || id == 5:
		get_node("FoodHumor").hide()
		get_node("FoodBack").hide()
	if id == 2 || id == 5:
		get_node("EnergyHumor").hide()
		get_node("EnergyBack").hide()