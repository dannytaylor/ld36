
extends Node2D

var anim = "fire1"
var new_anim = "fire1"

func _ready():
	set_process(true)
	
func _process(delta):
	if gamestate.fuel < 0.1:
		new_anim = "off"
	elif gamestate.fuel < 20:
		new_anim = "fire3"
	elif gamestate.fuel < 60:
		new_anim = "fire2"

	if (new_anim!=anim):
		anim = new_anim
		get_node("Sprite/anim").play(anim)
	

