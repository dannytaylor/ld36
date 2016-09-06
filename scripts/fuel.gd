
extends Area2D

func _ready():
	get_node("ding").play("fuel")

func _on_body_enter( body ):
	if (body extends preload("res://scripts/player1.gd")):
		print("p1 gets points")
		get_node("ding").play("spawn")
		if gamestate.fuel > 90:
			gamestate.fuel = 100
		else:
			gamestate.fuel += 10
		hide()
		queue_free()
	elif (body extends preload("res://scripts/player2.gd")):
		print("p2 gets points")
		get_node("ding").play("spawn")
		gamestate.fuel -= 10
		hide()
		queue_free()
