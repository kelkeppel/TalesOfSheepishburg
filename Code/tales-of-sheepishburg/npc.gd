extends CollisionObject3D
class_name NPC

#Depending on when in the story you are, interacting with an NPC should
#give you a different conversation. This variable keeps track of the scene.
var scene_number = 2

#The default prompt message when you go up to an NPC
@export var prompt_message = "Interact"

#Load in the dialogue file
@export var dialogue_file = "res://Dialogue/sample.txt"

#this is the function that runs when the NPC is interacted with
func on_interact():
	print(" interacted with ", name)
	
	$AudioStreamPlayer3D.play()
	load_from_file()
	
#_on_ready runs once when the node is instantiated at the start of the game.
func _on_ready():
		$InteractRay.interacted.connect(on_interact)
		#just a debug print to verify it connects, can remove later
		if $InteractRay.interacted.is_connected(on_interact):
			print("interact signal is connected")
	
	
	#load from file function splits the dialogue into the current scene, 
	#and then splits the scene's dialogue into individual lines
	
func load_from_file():
	#open the dialogue file and save its whole text into a variable
	var file = FileAccess.open(dialogue_file, FileAccess.READ)
	var content = file.get_as_text()
	
	#build the scene marker string to look for
	var scene_marker = "|" + str(scene_number) + "|"
	var scene_dialogue = content.split(scene_marker)
	
	#the split function removes the |num| marker from the text
	#if the scene marker is the first thing in the string, then index 0 will be blank
	var current_scene_dialogue = scene_dialogue[1].split("`")
	
	#while there is more dialogue available, print it
	#start it at 1 instead of 0 because 0 is always a blank space
	for i in range(1, current_scene_dialogue.size()):
		print(current_scene_dialogue[int(i)])
	
	return content
	
