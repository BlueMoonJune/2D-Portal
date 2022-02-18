extends Node2D

var poly : Polygon2D 
export var targetpath : NodePath
var target : Node2D
export var frames : Resource
export var pcamerap : NodePath
var pcamera : Camera2D
export var pairedp : NodePath
var paired : Node2D
var camera : Node2D
var enteredbodies : Dictionary

func basis(t : Transform2D):
	return Transform2D(t.x,t.y,Vector2.ZERO)

func _ready():
	$AnimatedSprite.frames = frames
	poly = $Polygon2D
	camera = $Viewport/Camera2D
	target = get_node(targetpath)
	pcamera = get_node(pcamerap)
	paired = get_node(pairedp)
	poly.texture = $Viewport.get_texture()
	
func _process(delta):
	if Engine.editor_hint:
		_ready()
	else:
		if name == "Portal2222":
			print(self, camera.global_transform)
	$Viewpoint.global_position = target.global_position
	var toppoint = -1000 * ($Viewpoint.position - $Top.position)
	var bottompoint = -1000 * ($Viewpoint.position - $Bottom.position)
	poly.polygon = [ $Top.position, $Bottom.position, bottompoint + $Bottom.position, toppoint + $Top.position]
	for body in enteredbodies.keys():
		if body.get_class() == "KinematicPortalTraveller":
			var side = sign((body.global_position - global_position).dot(global_transform.x))
			body.travelled = false
			if enteredbodies[body] != side and !body.travelled:
				print('crossed portal')
				body.travelled = true
				body.global_transform = paired.global_transform * (global_transform.affine_inverse() * body.global_transform).rotated(PI)
				print(body.velocity)
				body.velocity = basis(paired.global_transform) * (basis(global_transform.affine_inverse()) * body.velocity).rotated(PI)
				print(body.velocity)
				enteredbodies.erase(body)
	
	$Floor.scale.x = $FloorRay.cast_to.length() - $FloorRay.get_collision_point().distance_to($FloorRay.global_position)
	$Ceiling.scale.x = $CeilingRay.cast_to.length() - $CeilingRay.get_collision_point().distance_to($CeilingRay.global_position)
	
	

func _on_Area2D_body_entered(body):
	print(self, ' disabled ', body)
	enteredbodies[body] = sign((body.global_position - global_position).dot(global_transform.x))
	body.set_collision_mask_bit(0, false)
	body.set_collision_layer_bit(0, false)


func _on_Area2D_body_exited(body):
	if !body.travelled:
		print(self, ' enabled ', body)
		enteredbodies.erase(body)
		body.set_collision_mask_bit(0, true)
		body.set_collision_layer_bit(0, true)
	else: print(self, ' didnt enable ', body, ' as object travelled')
