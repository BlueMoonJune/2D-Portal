extends KinematicBody2D

var velocity : Vector2 = Vector2.ZERO
var grav = 9.8
var jump = 200
var walk_speed = 50
var run_speed = 120
var ground_accel = 800
var air_accel = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	var move = Input.get_axis("left","right")
	
	var accel
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = -jump
		else: velocity.y = 1
		accel = ground_accel
	else: 
		velocity.y += grav * 80 * delta
		accel = air_accel
		
	if Input.is_action_pressed("run"):
		velocity.x = move_toward(velocity.x, move*run_speed, accel*delta)
	else:
		velocity.x = move_toward(velocity.x, move*walk_speed, accel*delta)
		
	velocity = move_and_slide(velocity, Vector2.UP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
