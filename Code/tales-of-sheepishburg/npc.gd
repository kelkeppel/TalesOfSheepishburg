extends Interactable
var scene_number = 2

func _on_ready():
	load_from_file()

func _on_interacted(body):
	$AudioStreamPlayer3D.play()
	load_from_file()
	
func load_from_file():
	#open the dialogue file and save its whole text into a var
	var file = FileAccess.open(dialogue_file, FileAccess.READ)
	var content = file.get_as_text()
	
	#build the scene marker string to look for
	var scene_marker = "|" + str(scene_number) + "|"
	var scene_dialogue = content.split(scene_marker)
	
	#the split function removes the |num| marker from the text
	#if the scene marker is the first thing in the string, then index 0 will be blank
	
	#we can disregard any text from the file that falls before or after the current scene marker
	#when the scene marker updates, the function should be loaded again 
	#basically like a giant loop except if you do it in an actual loop it would need to be handled
	#in some other background script that calls the load_from_file func from each interactable each time the scene marker is updated
	#and also has a case for when an interactable doesn't have dialogue or doesn't have one for that scene marker
	
	var current_scene_dialogue = scene_dialogue[1].split("`")
	
	print("Line [0]: ", current_scene_dialogue[0])
	print("Line [1]: ", current_scene_dialogue[1])
	return content
	
