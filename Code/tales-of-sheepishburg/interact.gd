#This script works with the InteractRay to detect Interactables and show their message
extends RayCast3D

@onready var prompt = $Prompt
func _physics_process(delta):
	prompt.text = ""
	if is_colliding():
		var colliderObj = get_collider()
		
		if colliderObj is Interactable:
			prompt.text = colliderObj.prompt_message
	
			#this is looking for the interact key from the input map in the settings
			if Input.is_action_just_pressed("interact"):
				colliderObj.interact(owner)
