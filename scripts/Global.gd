extends Node

var death_player_global = 0
var start_global = false

var points = 000
var delta_calc = 0

func _ready():
	pass

func _process(delta):
	if start_global == true:
		delta_calc += 1
	
	if delta_calc > 300:
		points += 1
		delta_calc = 0
	pass


