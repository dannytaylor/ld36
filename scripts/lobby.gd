
extends Control
var set_time

func _ready():
	set_process(true)

func _process(delta):
	set_time = get_node("panel/match_set").get_value()*10+30
	get_node("panel/match_text").set_text("match time: "+str(set_time))

func _on_start_pressed():
	#if (get_node("panel/char1").is_pressed() == get_node("panel/char2").is_pressed()):
	#	get_node("panel/error").set_text("can't play as the same char")
	#	print("oops same char")
	#else:
	#print("success diff chars")
	gamestate.timer = get_node("panel/match_set").get_value()*10+30
	gamestate.begin_game()
