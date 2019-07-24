extends KinematicBody2D

var SPEED = 200
var VELOCITY = Vector2()

func _ready():
	get_node(".").add_to_group("shot_enemy")
	var waiting_timer = Timer.new()
	waiting_timer.set_wait_time(5)
	waiting_timer.set_one_shot(true)
	self.add_child(waiting_timer)
	waiting_timer.start()
	yield(waiting_timer, "timeout")
	get_node(".").queue_free()
	pass

func _physics_process(delta):
	if not $VisibilityNotifier2D.is_on_screen():
		call_deferred("queue free")
	else:
		pass

	VELOCITY.y = SPEED
	VELOCITY = move_and_slide(VELOCITY).normalized()

func _on_player_scenario_invade_body_entered(body):
	if body.is_in_group("enemies"):
		pass
	else:
		get_node(".").queue_free()