#code from the tutorial: https://docs.godotengine.org/en/4.4/getting_started/first_3d_game/03.player_movement_code.html
extends CharacterBody3D

#speed is meters per second
@export var speed = 4
var target_velocity = Vector3.ZERO

#the physics process function is specifically used 
#because it updates nodes with the physics engine in fixed time intervals (not fixed to framerate)
func _physics_process(delta):
	#local variable to hold the input
	var direction = Vector3.ZERO
	#check for input
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_backward"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	#normalize the vector so if the player is pressing two keys at once (going diagonal) it'll be the same speed
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	#make the character rotate depending on which direction the player is going
	$Pivot.basis = Basis.looking_at(direction)
	
	#calculate the speed the character goes
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	velocity = target_velocity
	#this is a built in function that helps smooth out movement
	move_and_slide()
