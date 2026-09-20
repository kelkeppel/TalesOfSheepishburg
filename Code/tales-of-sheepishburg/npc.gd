extends Interactable

func _on_ready():
	load_from_file()

func _on_interacted(body):
	$AudioStreamPlayer3D.play()
	print(load_from_file())
	
func load_from_file():
	var file = FileAccess.open(dialogue_file, FileAccess.READ)
	var content = file.get_as_text()
	
	var dialogue_lines = content.split("`")
	print(dialogue_lines[0])
	return content
	
