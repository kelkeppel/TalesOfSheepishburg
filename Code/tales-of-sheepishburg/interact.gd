#This class is attached to the Interact Ray which is part of the player.
#It detects NPC objects and emits the interact signal
extends RayCast3D
signal interacted

#This is the text that appears on screen when you walk up to an NPC
@onready var prompt = $Prompt

func _physics_process(delta):
	prompt.text = ""
	if is_colliding():
		var colliderObj = get_collider()
		
		if colliderObj is NPC:
			prompt.text = colliderObj.prompt_message
			
			#If the ray is colliding with something which is an npc,
			#then check if it's connected. If not, connect it.
			if !interacted.is_connected(colliderObj.on_interact):
				interacted.connect(colliderObj.on_interact)
				print("interacted signal connected to ", colliderObj)
	
			#this is looking for the interact key from the input map in the settings
			if Input.is_action_just_pressed("interact"):
				print("emited interact signal")
				interacted.emit()
