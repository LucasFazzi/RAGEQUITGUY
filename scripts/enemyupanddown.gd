extends KinematicBody2D

var shuffle_up = range (100,200)
var shuffle_down = range (-200,-100)
var MOVE_SPEED_UP_MAX 
var MOVE_SPEED_DOWN_MAX 
var raycastupshort = false
var raycastdownshort = false
var VELOCITY = Vector2()

func _ready():
	randomize()
	shuffle_down.shuffle()
	shuffle_up.shuffle()
	MOVE_SPEED_UP_MAX = shuffle_up[1]
	MOVE_SPEED_DOWN_MAX = shuffle_down[1]
	$".".add_to_group("enemies")
	if raycastupshort == false and raycastdownshort == false:
		var choose = randi()%2+1
		if choose == 1:
			raycastupshort = true
			raycastdownshort = false
		if choose == 2:
			raycastupshort = false
			raycastdownshort = true

func _physics_process(delta):
	if $enemeyupanddownraycast_down.is_colliding():
		raycastupshort = true
		raycastdownshort = false

	if $enemyupanddownraycast_up.is_colliding():
		raycastupshort = false
		raycastdownshort = true

	if raycastupshort == true:
		VELOCITY.y = MOVE_SPEED_DOWN_MAX
		VELOCITY = move_and_slide(VELOCITY).normalized()

	if raycastdownshort == true:
		VELOCITY.y = MOVE_SPEED_UP_MAX
		VELOCITY = move_and_slide(VELOCITY).normalized()