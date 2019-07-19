extends Area2D

func _ready():
	pass

func _on_exit_body_entered(body):
	if body.is_in_group("player"):
		get_parent().get_node("player").visible = false
		$dooropening_audio.play()
		var waiting_timer = Timer.new()
		waiting_timer.set_wait_time(0.1)
		waiting_timer.set_one_shot(true)
		self.add_child(waiting_timer)
		waiting_timer.start()
		yield(waiting_timer, "timeout")
		get_tree().change_scene("res://scenes/lvl9.tscn")
		call_deferred("queue_free")
	else:
		pass