
extends Node

var fuel
var timer
var frame = 0
var frame_lock
var pause_lock
var game_started
var pause_screen
var start_count

func _ready():
	pause_lock = false
	game_started = false
	start_count = true
	set_pause_mode(3)
	set_process(true)
	
func _process(delta):
	#if Input.is_action_pressed("exit"):
	#	get_tree().quit()
	
	#handle pauses
	if game_started and !start_count:
		if Input.is_action_pressed("back") and !pause_lock and !frame_lock:
			pause_game()
				
		if !Input.is_action_pressed("back") and pause_lock:
			pause_lock = false
		
		if gamestate.frame_lock == true:
			if Input.is_action_pressed("ui_cancel"):
				gamestate.game_started = false
				get_tree().get_root().get_node("lobby").show()
				get_tree().get_root().get_node("stage").queue_free()
				get_tree().set_pause(false)
			

func pause_game():
	pause_lock = true
	print("(un)pause")
	get_tree().set_pause(!get_tree().is_paused())
	
	pause_screen = get_tree().get_root().get_node("stage/winner")
	if pause_screen.is_hidden():
		pause_screen.show()
	else:
		pause_screen.hide()

func begin_game():
	var stage = load("res://scenes/stage.tscn").instance()
	get_tree().get_root().add_child(stage)
	get_tree().get_root().get_node("lobby").hide()