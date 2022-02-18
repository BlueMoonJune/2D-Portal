tool

extends Camera2D

export var targetpath : NodePath
var target : Node2D

func _ready():
	target = get_node(targetpath)
	
func _process(delta):
	position = target.position
