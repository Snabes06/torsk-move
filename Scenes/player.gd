extends CharacterBody3D

const speed = 20.0
const jump_speed = 10.0
const fall_speed = 10.0

var x_velo = 0
var y_velo = 0
var z_velo = 0
var look_vector = Vector3.FORWARD

# Hides the mouse
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func _physics_process(delta: float) -> void:
	# Jump Handling
	if not is_on_floor():
		y_velo = y_velo - (jump_speed * delta)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		y_velo = 1 
	
	# Movement dir handling
	z_velo = Input.get_axis("move_forward", "move_backward")
	x_velo = Input.get_axis("move_left", "move_right")
	
	# Apply and run movement
	velocity = Vector3(x_velo, y_velo, z_velo) * speed
	move_and_slide()



func _unhandled_input(event: InputEvent) -> void:
	# Handles mouse motion, rotates the character
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.02)
