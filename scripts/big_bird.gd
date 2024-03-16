extends CharacterBody2D

@export var bomb : PackedScene
@export var fruits : PackedScene
var speedX = 100
var speedY = 25
var directionX = 1
var directionY = 1
var time = 0.0
var is_timer_directionX_set = false
var is_timer_set = false

func speedProgression():
	speedX = 100 + (Global.score / 25)
	speedX = clamp(speedX, 100, 300)
		
func moveX():
	velocity.x = speedX * directionX
	
func moveY(delta):
	position.y += (cos(time * 5) * 35) * delta  
	
	time += delta
	
func ChangeXDir():
	directionX = directionX * -1
	
func collisionChangeXDir(delta):
	if move_and_collide(velocity * delta) != null:
		directionX *= -1
		
func createFruit():
	var f = fruits.instantiate()
	get_parent().add_child(f)
	var fruitPos = position
	fruitPos.y += 20
	f.position = fruitPos

func createBomb():
	var b = bomb.instantiate()
	get_parent().add_child(b)
	var bombPos = position
	bombPos.y += 20
	b.position = bombPos
	
func createSomething():
	var r = randi()%20
	if r > 15:
		createBomb()
	else:
		createFruit()
		
func _on_timer_timeout():
	is_timer_set = false
	createSomething()

func _on_timer_direction_x_timeout():
	is_timer_directionX_set = false
	ChangeXDir()

func _process(delta):
	if !is_timer_set:
		$Timer.start(randf()+0.7)
		is_timer_set = true
	if position.x < Global.playerXPos and abs(position.x - Global.playerXPos) > 400:
		directionX = 1
	elif position.x > Global.playerXPos and abs(position.x - Global.playerXPos) > 400:
		directionX =  -1
	
	if !is_timer_directionX_set:
		$Timer_directionX.start(randi()% 5 -(speedX * 0.005) + 2)
		is_timer_directionX_set = true
		
	$AnimatedSprite2D.play("idle")
	moveX()
	moveY(delta)
	speedProgression()
	collisionChangeXDir(delta)
	

