#This script is added to anything which should be able to be interacted with by the player.
#Specific prompt messages can be assigned per instance
extends CollisionObject3D
class_name Interactable

#defines a signal which can be sent out whenever something is interacted with, and pass the node that did it
signal interacted(body)

@export var prompt_message = "Interact"

#this is the function that runs when the object is interacted with
func interact(body):
	print(body.name, " interacted with ", name)
	#emits the interacted signal
	interacted.emit(body)
