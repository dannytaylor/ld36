
extends Node

var player
var feet
var jump_height = 1600
var move_speed = 500
var sound_count = 0

var anim = "idle"
var new_anim = "idle"
var is_jumping = false
var is_right
var jump_lock

var crouch_lock = false


var lx
var ly

func _ready():
	set_process(true)
	feet = get_node("feet")
	feet.add_exception(self) # the player
	set_mode(2)

func _process(delta):
	if !gamestate.frame_lock:
		sound_count += 1
		
		lx = get_linear_velocity().x
		ly = get_linear_velocity().y
		
		if feet.is_colliding():
			is_jumping = false
			if Input.is_action_pressed("p2_up") and !jump_lock:
				set_axis_velocity(Vector2(0,-jump_height))
				jump_lock = true
				if sound_count > 0:
					get_node("sound").play("jump")
					sound_count = -2
			elif Input.is_action_pressed("p2_down"):
					crouch_lock = true
			else:
				crouch_lock = false
		else:
			crouch_lock = false
		
		if ly > 0:
			jump_lock = false
		elif ly != 0:
			is_jumping = true
		
		if !crouch_lock:
			if Input.is_action_pressed("p2_right"):
				set_axis_velocity(Vector2(move_speed,0))
			if Input.is_action_pressed("p2_left"):
				set_axis_velocity(Vector2(-move_speed,0))
		
		if is_jumping:
			if ly>0:
				new_anim = "jump_down"
			else:
				new_anim = "jump_up"
		else:
			if lx == 0:
				new_anim = "idle"
			else:
				new_anim = "run"
		if lx<0 and is_right:
			is_right = false
			get_node("Sprite").set_flip_h(false)
		if lx>0 and !is_right:
			is_right = true
			get_node("Sprite").set_flip_h(true)
		if crouch_lock:
			new_anim = "crouch"
			if Input.is_action_pressed("p2_right") and !is_right:
				is_right = true
				print("test")
				get_node("Sprite").set_flip_h(true)
			elif Input.is_action_pressed("p2_left") and is_right:
				is_right = false
				get_node("Sprite").set_flip_h(false)
	elif gamestate.frame_lock:
		if Input.is_action_pressed("p2_down"):
			new_anim = "crouch"
		else:
			new_anim = "idle"
	if (new_anim!=anim):
		anim = new_anim
		get_node("Sprite/anim").play(anim)
