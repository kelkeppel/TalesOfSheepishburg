extends RayCast3D

@onready var prompt = $Prompt
func _physics_process(delta):
	prompt.text = ""
	if is_colliding():
		var colliderObj = get_collider()
		
		if colliderObj is Interactable:
			prompt.text = colliderObj.prompt_message
	
		
