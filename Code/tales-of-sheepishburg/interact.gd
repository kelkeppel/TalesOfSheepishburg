#This script works with the InteractRay to detect Interactables and show their message
extends RayCast3D
signal interacted

@export var npcNode:Node

@onready var prompt = $Prompt
func _physics_process(delta):
	
	print("npc path is ", npcNode)
	prompt.text = ""
	if is_colliding():
		#var colliderObj = get_collider()
		var colliderObj = npcNode
		print(colliderObj.prompt_message)
		
		if colliderObj is NPC:
			prompt.text = colliderObj.prompt_message
			
			#If the ray is colliding with something which is an npc,
			#then check if it's connected. If not, connect it.
			if !interacted.is_connected(colliderObj.get_parent):
				interacted.connect(colliderObj.get_parent)
				print("interacted signal connected to ", colliderObj)
	
			#this is looking for the interact key from the input map in the settings
			if Input.is_action_just_pressed("interact"):
				print("emited interact signal")
				interacted.emit()
