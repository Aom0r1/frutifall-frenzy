extends Area2D

@export var speed = 160
var boomOnce = false
	
func _on_area_entered(area):
	if(!boomOnce):
		if area.name == "mask_dude":
			Global.score -= 100
			Global.health -= 1
			Global.getHit = true
			Global.fruitsCollected = 1
			speed = 0
			playBoomAnimation()
		elif area.name == "ground":
			$Timer2.start()
			speed = 0

func playBoomAnimation():
	$Timer.start()
	$AnimatedSprite2D.play("boom")

	boomOnce = true 
	
func _on_timer_timeout():
	
	Global.getHit = false
	queue_free()

func _on_timer_2_timeout():
	playBoomAnimation()

	
func _physics_process(delta):
	position += transform.y * speed * delta
	
	if speed:
		$AnimatedSprite2D.play("idle")
		
		
