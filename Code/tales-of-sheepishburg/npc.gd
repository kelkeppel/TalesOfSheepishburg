extends CollisionObject3D
class_name NPC

@export var pathToNode = get_path()

var scene_number = 1

@export var prompt_message = "Interact"

#Load in the dialogue file
@export var dialogue_file = "res://Dialogue/sample.txt"

#this is the function that runs when the NPC is interacted with
func on_interact():
	print(" interacted with ", name)
	
	$AudioStreamPlayer3D.play()
	load_from_file()
	
#the problem with this is that its checking for a signal once at the start before the signal is emitted

func _on_ready():
	$InteractRay.interacted.connect(on_interact)
	while true:
		if $InteractRay.interacted.is_connected(on_interact):
			print("interact signal is connected")
	
	
func load_from_file():
	#open the dialogue file and save its whole text into a var
	var file = FileAccess.open(dialogue_file, FileAccess.READ)
	var content = file.get_as_text()
	
	#build the scene marker string to look for
	var scene_marker = "|" + str(scene_number) + "|"
	var scene_dialogue = content.split(scene_marker)
	
	#the split function removes the |num| marker from the text
	#if the scene marker is the first thing in the string, then index 0 will be blank
	var current_scene_dialogue = scene_dialogue[1].split("`")
	
	#while there is more dialogue available, print it
	for i in current_scene_dialogue:
		print(current_scene_dialogue[int(i)])
	
	return content
	
