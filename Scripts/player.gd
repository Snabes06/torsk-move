extends CharacterBody3D

const speed = 20.0
const jump_speed = 10.0
const fall_speed = 10.0
const sprint_speed = 1.5

var y_velo = 0
var acceleration = 0.5
var base = 0
var sensitivity = 0.005


@onready var animation = $Barbarian/AnimationPlayer
@onready var speedLines = $HUD/ColorRect
@onready var speedDisplay = $HUD/Label

# Hides the mouse
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Jump Handling
	if not is_on_floor():
		y_velo = y_velo - (fall_speed * delta)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		y_velo = 6
	# Apply and run movement
	if Input.is_action_pressed("move_forward"):
		if Input.is_action_pressed("sprint"):
			if is_on_floor():
				_accelerate()
				animation.play("Running_A")
			velocity = Vector3(sin(0.01745329252*rotation_degrees.y) * 0.5 * acceleration, y_velo, cos(0.01745329252*rotation_degrees.y) * 0.5 * acceleration) * speed * sprint_speed
		else:
			if is_on_floor():
				base = 0
				speedLines.visible = false
				animation.play("Walking_A")
			velocity = Vector3(sin(0.01745329252*rotation_degrees.y) * 0.5, y_velo, cos(0.01745329252*rotation_degrees.y) * 0.5) * speed
		move_and_slide()
	else:
		_stop()

func _accelerate() -> void:
	if acceleration < 8:
		base += 0.01
		acceleration = 0.5 + pow(base, 0.25)
	if acceleration > 1.5:
		speedLines.visible = true

func _stop() -> void:
	base = 0
	speedLines.visible = false
	_deccelerate()

func _deccelerate() -> void:
	velocity = Vector3(0, y_velo, 0) * speed
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	# Handles mouse motion, rotates the character
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensitivity)
