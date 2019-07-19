extends Area2D

var exit3_position

func _ready():
	exit3_position = get_parent().get_node("exit6").global_position
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
		get_parent().get_node("player").set_position(exit3_position)
		get_parent().get_node("player").visible = true
	if body.is_in_group("enemies"):
		pass