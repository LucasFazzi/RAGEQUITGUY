extends KinematicBody2D

var shuffle_right = range (100,200)
var shuffle_left = range (-200,-100)
var shuffle_up = range (100,200)
var shuffle_down = range (-200,-100)

var MOVE_SPEED_RIGHT_MAX 
var MOVE_SPEED_LEFT_MAX 
var MOVE_SPEED_UP_MAX
var MOVE_SPEED_DOWN_MAX

var raycastleftshort = false
var raycastrightshort = false
var raycastupshort = false
var raycastdownshort = false


var VELOCITY = Vector2()

func _ready():
	randomize()
	shuffle_right.shuffle()
	shuffle_left.shuffle()
	shuffle_down.shuffle()
	shuffle_up.shuffle()
	MOVE_SPEED_RIGHT_MAX = shuffle_right[1]
	MOVE_SPEED_LEFT_MAX = shuffle_left[1]
	MOVE_SPEED_UP_MAX = shuffle_up[1]
	MOVE_SPEED_DOWN_MAX = shuffle_down[1]
	$".".add_to_group("enemies")


	if raycastleftshort == false and raycastrightshort == false:
		var choose = randi()%2+1
		if choose == 1:
			raycastleftshort = true
			raycastrightshort = false
		if choose == 2:
			raycastleftshort = false
			raycastrightshort = true


func _physics_process(delta):
	if $enemydiagonal_raycastright.is_colliding():
		raycastrightshort = true
		raycastleftshort = false

	if $enemydiagonal_raycastleft.is_colliding():
		raycastleftshort = true
		raycastrightshort = false

	if $eneymdiagonal_raycastdown.is_colliding():
		raycastdownshort = true
		raycastupshort = false

	if $eneymdiagonal_raycastup.is_colliding():
		raycastupshort = true
		raycastdownshort = false

	if raycastrightshort == true:
		VELOCITY.x = MOVE_SPEED_LEFT_MAX
		VELOCITY.y = randi()%MOVE_SPEED_UP_MAX+MOVE_SPEED_DOWN_MAX
		VELOCITY = move_and_slide(VELOCITY).normalized()

	if raycastleftshort == true:
		VELOCITY.x = MOVE_SPEED_RIGHT_MAX
		VELOCITY.y = randi()%MOVE_SPEED_UP_MAX+MOVE_SPEED_DOWN_MAX
		VELOCITY = move_and_slide(VELOCITY).normalized()
	
	if raycastdownshort == true:
		VELOCITY.y = MOVE_SPEED_DOWN_MAX
		VELOCITY = move_and_slide(VELOCITY).normalized()

	if raycastupshort == true:
		VELOCITY.y = MOVE_SPEED_UP_MAX
		VELOCITY = move_and_slide(VELOCITY).normalized()
