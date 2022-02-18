extends "res://src/scripts/KinematicPortalTraveller.gd"

var grav = 9.8
var jump = 200
var walk_speed = 50
var run_speed = 120
var ground_accel = 800
var air_accel = 100
var col : CollisionShape2D
var snap : Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	col = $CollisionShape2D
	pass # Replace with function body.
	
func _physics_process(delta):
	var move = Input.get_axis("left","right")
	
	if move != 0:
		$Player.flip_h = move < 0
	
	var accel
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = -jump
			snap = Vector2(0,0)
		else: 
			velocity.y = 1
			snap = Vector2(0,10)
		accel = ground_accel
		col.shape.height = 6
		col.position.y = 1
		$Player.rotation = move_toward(fmod($Player.rotation + PI, TAU), PI, delta * 30) - PI
		$Player.animation = "idle"
	else:
		
		velocity.y += grav * 80 * delta
		accel = air_accel
		col.shape.height = 0
		col.position.y = 4
		$Player.rotation += delta * 20
		$Player.animation = "crouch"
		
	rotation -= rotation * delta * 10
		
	if Input.is_action_pressed("run"):
		velocity.x = move_toward(velocity.x, move*run_speed, accel*delta)
	else:
		velocity.x = move_toward(velocity.x, move*walk_speed, accel*delta)
		
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP, true, 4, 0.8, true)
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
