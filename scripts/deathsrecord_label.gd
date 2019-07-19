extends RichTextLabel

func _ready():
	pass

func _process(delta):
	set_text("Deaths:  "+str(get_node("/root/Global").death_player_global))
	pass
