extends CharacterBody3D

@export var camera: Camera3D
@export var mouse_sensitivity = 0.005

const WALK_SPEED = 3.0
const RUN_SPEED = 6.0
const CROUCH_SPEED = 1.5
const JUMP_VELOCITY = 3.0


var sprinting: bool
var crouching: bool

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	sprinting = false
	crouching = false
	camera.current = true


func _input(event):
	if event is InputEventMouseMotion and (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
	
	if event.is_action_pressed("tab"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event.is_action_pressed("del"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#check for shift or crouch
	if Input.is_action_pressed("shift"):
		sprinting = true
	else:
		sprinting = false
	if Input.is_action_pressed("ctrl"):
		crouching = true
	else:
		crouching = false
	
	#assign movement speed
	var speed: float
	if sprinting:
		speed = RUN_SPEED
	elif crouching:
		speed = CROUCH_SPEED
	else:
		speed = WALK_SPEED
		
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("a", "d", "w", "s")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
