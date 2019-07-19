extends Node2D

signal start

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("jump"):
		get_tree().change_scene("res://scenes/lvl1.tscn")
		emit_signal("start")
		queue_free()

func _on_startscenenode_start():
	get_node("/root/Global").start_global = true