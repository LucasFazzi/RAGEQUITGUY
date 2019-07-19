extends Area2D

func _on_exit_body_entered(body):
	if body.is_in_group("player"):
		pass
	if body.is_in_group("enemies"):
		pass