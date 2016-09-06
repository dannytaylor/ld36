
extends Area2D

var pickup_lock
var pos
var p1_lock

func _ready():
	pickup_lock = false
	p1_lock = false
	get_node("ding").play("spawn")
	set_process(true)
	
func _process(delta):
	if p1_lock:
		pos = get_tree().get_root().get_node("stage/player1").get_pos()
		set_pos(pos)
	
func _on_body_enter( body ):
	#collides with player and not locked
	if (body extends preload("res://scripts/player1.gd")) and !pickup_lock:
		if Input.is_action_pressed("p1_down"):
			if !p1_lock:
				#attach to p1
				p1_lock = true
				pickup_lock = true
				get_node("Sprite").set_pos(get_node("Sprite").get_pos()-Vector2(0,60))
		
	elif (body extends preload("res://scripts/player2.gd")) and p1_lock:
		if Input.is_action_pressed("p1_down"):
			print("test3")
			hide()
			queue_free()
