extends Node2D

func _process(_delta):
	$Label.text = "Score: " + str(Global.score)

	if Input.is_action_pressed("ui_page_up"):
		Global.score += 100
	if Input.is_action_pressed("ui_page_down"):
		Global.score -= 100
		
	if Input.is_action_pressed("f11"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
