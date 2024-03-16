extends Area2D

@export var speed = 120
var collectedOnce = false
var animArr = ["bannana", "apple", "pinaple", "kiwi", "cherries", "melon", "orange", "pineapple", "strawberry"]
var currFruit = animArr[randi()%animArr.size() - 1]

func _physics_process(delta):
	position += transform.y * speed * delta
	if speed:
		$AnimatedSprite2D.play(currFruit)

func _on_area_entered(area):
	if !collectedOnce:
		if area.name == "mask_dude":
			Global.score += 25
			Global.fruitsCollected += 1
			$AnimatedSprite2D.play("collected")
			collectedOnce = true
			
		elif area.name == "ground":
			Global.fruitsCollected = 1
			Global.score -= 25
			Global.health -=1
			$AnimatedSprite2D.play("collected")
			collectedOnce = true
	speed = 0
	$Timer.start()


func _on_timer_timeout():
	queue_free()
