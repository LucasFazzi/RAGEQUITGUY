extends Area2D

signal death_down

func _ready():
	pass

func _on_playerhitdown_body_entered(body):
	if body.is_in_group("enemies"):
		get_parent().jump()
		emit_signal("death_down")