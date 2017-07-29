extends KinematicBody2D

const SPEED = 150
var targetFloor = 2
var targetX = get_pos().x
var left = false
var right = false
var actualFloor = 2
var takingStairs = false
var up = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if takingStairs:
		set_z(1)
	else:
		set_z(2)

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
	print("floor15")
	right = false
	left = true


func _on_Floor1Up_body_enter( body ):
	print("floor1U")
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
	print("floor1D")
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
	print("floor05")
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
