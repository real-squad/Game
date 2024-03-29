extends Area2D
#walking movement speed player
export var speed = 400

var screen_size #naar mainworld.gd later???

func _ready(): #naar mainworld.gd later???
	screen_size = get_viewport_rect().size #naar mainworld.gd later???
	
func _process(delta):
	#sprint command
	if Input.is_action_pressed("ui_page_up"): #key to sprint
		speed = 800 #sprinting movement speed
	else:
		speed = 400 #walking movement speed
	#2-element structure that can be used to represent positions in 2d space or any other pair of numeric values.
	var velocity = Vector2()
		#move right
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	#move left
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	#move down
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	#move up
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	#when not moving, show idle position, 'still need to fix that it stays idle in the direction it was facing.'
	if velocity.x == 0 and velocity.y == 0:
		$AnimatedSprite.animation = "idle"
	#when moving right, show animation "right"
	if velocity.x > 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = false
	#when moving left, show animation flipped "right"
	if velocity.x < 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = true
	#when moving down, show animation "down"
	if velocity.y > 0:
		$AnimatedSprite.animation = "down"
	#when moving up, show animation "up"
	if velocity.y < 0:
		$AnimatedSprite.animation = "up"
	#when moving sideways to the right, show animation "right", 'not working'
	if velocity.x > 0 and velocity.y != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = false
	#when moving sideways to the left, show animation flipped "right", 'not working'
	if velocity.x < 0 and velocity.y != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = true
		