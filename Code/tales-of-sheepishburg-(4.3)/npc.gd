extends Interactable
const Balloon = preload("res://Dialogue/balloon.tscn")
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _on_interacted(body):
	$AudioStreamPlayer3D.play()
	
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)
