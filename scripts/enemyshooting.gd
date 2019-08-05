extends KinematicBody2D

var shuffle_right = range (100,200)
var shuffle_left = range (-200,-100)
var MOVE_SPEED_RIGHT_MAX 
var MOVE_SPEED_LEFT_MAX 
var MOVE_SPEED_ZERO = 0
var raycastleftshort = false
var raycastrightshort = false
var VELOCITY = Vector2()
var timeout = false

func _ready():
	randomize()
	shuffle_right.shuffle()
	shuffle_left.shuffle()
	MOVE_SPEED_RIGHT_MAX = shuffle_right[1]
	MOVE_SPEED_LEFT_MAX = shuffle_left[1]
	$".".add_to_group("enemies")
	$enemy_shootincollision.add_to_group("enemies")
	if raycastleftshort == false and raycastrightshort == false:
		var choose = randi()%2+1
		if choose == 1:
			raycastleftshort = true
			raycastrightshort = false
		if choose == 2:
			raycastleftshort = false
			raycastrightshort = true

func _physics_process(delta):
	if not $VisibilityNotifier2D.is_on_screen():
		VELOCITY.x = MOVE_SPEED_ZERO
	else:
		pass

	if $enemyshooting_leftraycast.is_colliding():
		raycastleftshort = true
		raycastrightshort = false

	if $enemyshooting_rightraycast.is_colliding():
		raycastleftshort = false
		raycastrightshort = true

	if raycastleftshort == true:
		VELOCITY.x = MOVE_SPEED_RIGHT_MAX
		VELOCITY = move_and_slide(VELOCITY).normalized()

	if raycastrightshort == true:
		VELOCITY.x = MOVE_SPEED_LEFT_MAX
		VELOCITY = move_and_slide(VELOCITY).normalized()

func _on_time_shooting_timeout():
	check_fire()

func check_fire():
	var waiting_timer = Timer.new()
	waiting_timer.set_wait_time(randi()%2+1)
	waiting_timer.set_one_shot(false)
	self.add_child(waiting_timer)
	waiting_timer.start()
	yield(waiting_timer, "timeout")
	var shot = preload("res://scenes/shot_enemy.tscn").instance()
	shot.position = $".".position
	get_parent().call_deferred("add_child",shot)
	shot.call_deferred("show")
	pass

