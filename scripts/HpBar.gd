extends TextureProgressBar

@onready var heart1 = $Hearts/HeartFull
@onready var heart2 = $Hearts/HeartFull2
@onready var heart3 = $Hearts/HeartFull3

func _process(_delta):
	var hArr = [heart1, heart2, heart3]
	
	for i in hArr:
		i.visible = false
	
	for i in range(Global.health):
		hArr[i].visible = true
