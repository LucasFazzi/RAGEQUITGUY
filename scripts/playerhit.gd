extends Area2D

signal death_down
signal death

func _ready():
	pass

func _on_playerhitdown_body_entered(body):
	if body.is_in_group("enemies"):
		get_parent().jump()
		emit_signal("death_down")
	if body.is_in_group("shot_enemy"):
		get_parent().jump()
		emit_signal("death_down")

func _on_playerhitdown_area_entered(area):
	if area.is_in_group("collisionground"):
		emit_signal("death")
