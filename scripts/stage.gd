
extends Node2D

var spawn_chance = 1.0
var spawn_point 

var countdown
var start_frame

onready var wintext = get_node("winner/wintext")
onready var shadow = get_node("shadow")

func _ready():
	gamestate.frame_lock = true
	get_tree().set_pause(false)
	
	gamestate.start_count = true
	countdown = 3
	start_frame = 0
	get_node("start_timer").show()
	
	get_node("winner").hide()
	wintext.set_text("paused")
	gamestate.fuel = 100
	#gamestate.timer = 60
	gamestate.frame = 0
	gamestate.game_started = true
	
	shadow.set_opacity(0)
	
	set_process(true)
	
	get_node("timer").set_text(str(gamestate.timer))
	get_node("timer").set("custom_colors/font_color",Color(0,0,0))
	get_node("timer").set("rect/scale",Vector2(1,1))
	
func _process(delta):
	if !gamestate.frame_lock:
		gamestate.fuel -= 0.05
		shadow.set_opacity((100-gamestate.fuel)/100)
		
		gamestate.frame += 1
		
		if (gamestate.timer <1):
			gamestate.frame_lock = true
			wintext.set_text("the winner is:\npilot man!\n \nspacebar back to menu")
			get_node("winner").show()
			get_tree().set_pause(true)
			
		elif (gamestate.fuel <0.05):
			gamestate.frame_lock = true
			wintext.set_text("the winner is\nthe grelmin!\n \nspacebar back to menu")
			get_node("winner").show()
			get_tree().set_pause(true)
		
		#roughly every second
		elif gamestate.frame == 49:
			gamestate.timer -= 1
			if gamestate.timer ==10:
				get_node("timer").set("custom_colors/font_color",Color(1,0.3,0.3))
				get_node("timer").set("rect/scale",Vector2(1.2,1.2))
			gamestate.frame = 0
			get_node("timer").set_text(str(gamestate.timer))
			
			#spawnthings
			if spawn_chance*rand_range(0,100)>98:
				randomize()
				spawn_point = get_node("spawn_points/spawn"+str(randi()%6+1))
				spawn_fuel(spawn_point)
				spawn_chance=0.4
			spawn_chance += 0.2
			
	#the 3 sec countdown at start
	if gamestate.start_count:
		start_frame += 1
		
		if start_frame == 100:
			start_frame = 0
			countdown -= 1
		
		if countdown > 0:
			get_node("start_timer").set_percent_visible((25.0+float(start_frame))/100)
		else:
			get_node("start_timer").set_percent_visible(1)
			get_node("start_timer").set_opacity(1 + float(countdown)/1 - float(start_frame)/100)
		
		if countdown == 3:
			get_node("start_timer").set_text("3...")
		elif countdown == 2:
			get_node("start_timer").set_text("2...")
		elif countdown == 1:
			get_node("start_timer").set_text("1...")
		elif countdown == 0:
			get_node("start_timer").set_text("START!")
			gamestate.frame_lock = false
		elif countdown == -2:
			get_node("start_timer").hide()
			gamestate.start_count = false
		
#spawning a fuel can
func spawn_fuel( spawn_point ):
	print("a fuel can was spawned")
	var spawn_pos = spawn_point.get_pos()
	var fuel_scene = load("res://scenes/fuel.tscn")
	var fuel = fuel_scene.instance()
	fuel.set_pos(spawn_pos)
	
	get_node("drops").add_child(fuel)