#code from the tutorial: https://docs.godotengine.org/en/4.4/getting_started/first_3d_game/03.player_movement_code.html
extends CharacterBody3D

@onready var animation_tree = $AnimationTree

#speed is meters per second
@export var speed = 4
var target_velocity = Vector3.ZERO

#the physics process function is specifically used 
#because it updates nodes with the physics engine in fixed time intervals (not fixed to framerate)
func _physics_process(delta):
	#local variable to hold the input
	var direction = Vector3.ZERO
	print("starting vector:", direction.length())
	
	#check for input
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	elif Input.is_action_pressed("move_left"):
		direction.x -= 1
	elif Input.is_action_pressed("move_backward"):
		direction.z += 1
	elif Input.is_action_pressed("move_forward"):
		direction.z -= 1
	else:
		#Instead of having it go straight to 0, it should be a decrement
		direction = Vector3.ZERO
		
	print("after input:", direction.length())
	
	#normalize the vector so if the player is pressing two keys at once (going diagonal) it'll be the same speed
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	print("after normalization:", direction.length())
	
	#set the rotation of the pivot node to the direction the character was last facing that wasn't 0
	if direction.z != 0 or direction.x != 0:
		$Pivot.basis = Basis.looking_at(direction)
		
	print("after rotation:", direction.length())
	
	#calculate the speed the character goes
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	print("after speed calc:", target_velocity.length())
	
	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (5 * delta)
	
	
	velocity = target_velocity
	animation_tree.set("parameters/BlendSpace1D/blend_position", floor(target_velocity.length()))
	print("velocity: ", velocity.length())
	#this is a built in function that helps smooth out movement
	move_and_slide()
