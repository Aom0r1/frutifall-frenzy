extends CharacterBody2D

var speed = 0
const jump_velocity = -400.0
const gravity = 1000
const fly_speed = 225
const walk_speed = 250

func showAnimation():
	if(Global.getHit):
		$AnimatedSprite2D.play("hit")
	else:
		if velocity.x != 0 and is_on_floor():
			$AnimatedSprite2D.play("run")
		else:
			$AnimatedSprite2D.play("idle")
			
		if velocity.y < 0:
			$AnimatedSprite2D.play("jump")
		elif velocity.y > 0:
			$AnimatedSprite2D.play("fall")
			
func getInputs():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	if Input.is_action_pressed("down") and !is_on_floor():
		if(velocity.y > 0):
			velocity.y *= 1.075
		else:
			velocity.y *= -1.075
		

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		$AnimatedSprite2D.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func changeSpeed(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		speed = fly_speed
	else:
		speed = walk_speed
		

func _physics_process(delta):
	if Global.health == 0:
		#queue_free()
		pass
	if Global.fruitsCollected % 5 == 0 and Global.health < Global.maxHealth:
		Global.health += 1
		Global.fruitsCollected = 1
	Global.playerXPos = position.x
	changeSpeed(delta)
	getInputs()		
	showAnimation()	
	move_and_slide()





