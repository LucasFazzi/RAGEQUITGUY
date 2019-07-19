extends KinematicBody2D

var shuffle_right = range (100,200)
var shuffle_left = range (-200,-100)
var MOVE_SPEED_RIGHT_MAX 
var MOVE_SPEED_LEFT_MAX 
var raycastleftshort = false
var raycastrightshort = false
var VELOCITY = Vector2()

func _ready():
	randomize()
	shuffle_right.shuffle()
	shuffle_left.shuffle()
	MOVE_SPEED_RIGHT_MAX = shuffle_right[1]
	MOVE_SPEED_LEFT_MAX = shuffle_left[1]
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
	if $enemyleftandright_RayCastleftshort.is_colliding():
		raycastleftshort = true
		raycastrightshort = false

	if $enemyleftandright_RayCastrightshort.is_colliding():
		raycastleftshort = false
		raycastrightshort = true

	if raycastleftshort == true:
		VELOCITY.x = MOVE_SPEED_RIGHT_MAX
		VELOCITY = move_and_slide(VELOCITY).normalized()

	if raycastrightshort == true:
		VELOCITY.x = MOVE_SPEED_LEFT_MAX
		VELOCITY = move_and_slide(VELOCITY).normalized()

	if not VELOCITY.x == 0:
		if not $monsterstep2_audio.is_playing():
			$monsterstep2_audio.play()
