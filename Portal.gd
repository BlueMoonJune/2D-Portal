tool
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
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
