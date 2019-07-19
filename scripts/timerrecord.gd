extends RichTextLabel

func _process(delta):
	set_text(str(get_node("/root/Global").points))
	pass

