extends Area2D

signal death_up

func _ready():
	pass

func _on_playerhitup_body_entered(body):
	if body.is_in_group("enemies"):
			get_parent().jump_cut()
			emit_signal("death_up")