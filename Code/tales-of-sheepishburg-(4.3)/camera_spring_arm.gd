extends SpringArm3D

@export var mouse_sensitivity: float = 0.005

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotation.y -= event.relative.x * mouse_sensitivity
		#keeps the rotation value between 0 and 360 degrees
		rotation.y = wrapf(rotation.y, 0.0, TAU)
		
		rotation.x -= event.relative.y * mouse_sensitivity
		#how much the camera can be angled up or down
		rotation.x = clamp(rotation.x, -PI/4, PI/10)
		
	#increase or decrease spring length to zoom in or out on character
	if event.is_action_pressed("Mouse Wheel Up"):
		spring_length -= 1
	if event.is_action_pressed("Mouse Wheel Down"):
		spring_length += 1
		
	if event.is_action_pressed("Mouse Toggle"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
