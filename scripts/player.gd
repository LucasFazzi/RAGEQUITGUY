extends KinematicBody2D

signal death_check

var MOVE_SPEED = 300
var JUMP_FORCE = 1100
var GRAVITY = 50
var MAX_FALL_SPEED = 1000
var START_POS
var death_check_counter = false
var y_velo = 0
var player_life = 100
var hit_down = false
var hit_down_total = false
var hit_up = false
var hit_left = false
var hit_right = false

func _ready():
	$".".add_to_group("player")
	$deathanimation.visible = false
	var player_pos = ($".".position)
	START_POS = player_pos

func _physics_process(delta):
	check_game_over()
	var move_dir = 0

	if Input.is_action_pressed("move_right"):
		move_dir += 1
		$spriteplayer.play("right")

	if Input.is_action_pressed("move_left"):
		move_dir -= 1
		$spriteplayer.play("left")

	if $player_raycastleft.is_colliding():
		hit_left = true
		if hit_left == true:
			if $playerjump_audio.is_playing():
				$playerjump_audio.stop()
			if not $hit_player.is_playing():
				$hit_player.play()
			$hit_modulate.play("hit_modulate")
			player_life -= 35
			move_dir += 3
			hit_left = false

	if $player_raycastright.is_colliding():
		hit_right = true
		if hit_right == true:
			if $playerjump_audio.is_playing():
				$playerjump_audio.stop()
			if not $hit_player.is_playing():
				$hit_player.play()
			$hit_modulate.play("hit_modulate")
			player_life -= 35
			move_dir += 3
			hit_right = false

	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1)).normalized()

	var grounded = is_on_floor()
	y_velo += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		jump()
	if Input.is_action_just_released("jump"):
		jump_cut()

	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED

	if is_on_ceiling():
		y_velo += GRAVITY
    
	if grounded:
		if move_dir == 0:
			$spriteplayer.play("idle")

func jump():
	y_velo = - JUMP_FORCE
	if not $playerjump_audio.is_playing():
		$playerjump_audio.play()

func jump_cut():
	if y_velo < - 100:
		y_velo = - 70

func _on_playerhitdown_death_down():
	hit_down = true
	if hit_down == true:
		if $playerjump_audio.is_playing():
			$playerjump_audio.stop()
		if not $hit_player.is_playing():
			$hit_player.play()
		$hit_modulate.play("hit_modulate")
		player_life -= 35
		hit_down = false

func _on_playerhitup_death_up():
	hit_up = true
	if hit_up == true:
		if $playerjump_audio.is_playing():
			$playerjump_audio.stop()
		if not $hit_player.is_playing():
			$hit_player.play()
		$hit_modulate.play("hit_modulate")
		player_life -= 35
		hit_up = false

func _on_playerhitdown_death():
	hit_down_total = true
	if hit_down_total == true:
		if $playerjump_audio.is_playing():
			$playerjump_audio.stop()
		if not $hit_player.is_playing():
			$hit_player.play()
		$hit_modulate.play("hit_modulate")
		player_life -= 101
		hit_down = false

func check_game_over():
	if player_life >= 0:
		pass
	if player_life <= 0:
		$hit_modulate.play("blank_gameover")
		MOVE_SPEED = 0
		GRAVITY = 0
		JUMP_FORCE = 0
		MAX_FALL_SPEED = 0
		y_velo = 0
		death_check_counter = true
		$spriteplayer.visible = false
		$deathanimation.visible = true
		$hit_player.stop()
		$playerjump_audio.stop()
		if not $playerhitgameover_audio.is_playing():
			$playerhitgameover_audio.play()
		var waiting_timer = Timer.new()
		waiting_timer.set_wait_time(1)
		waiting_timer.set_one_shot(true)
		self.add_child(waiting_timer)
		waiting_timer.start()
		yield(waiting_timer, "timeout")
		get_parent().get_tree().reload_current_scene()
		if death_check_counter == true:
			emit_signal("death_check")
			death_check_counter = false


func _on_player_death_check():
	get_node("/root/Global").death_player_global += 1
	get_node("/root/Global").points += 100


