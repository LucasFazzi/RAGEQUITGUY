extends RichTextLabel

func _process(delta):
	set_text("Points:  "+str(get_node("/root/Global").points))
	pass

