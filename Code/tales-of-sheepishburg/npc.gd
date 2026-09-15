extends Interactable

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
dialogue_file = ""

func _on_interacted(body):
	$AudioStreamPlayer3D.play()
	
