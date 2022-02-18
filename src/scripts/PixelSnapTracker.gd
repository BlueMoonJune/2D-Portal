tool

extends Node2D


export var targetp : NodePath
var target : Node2D


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if !target:
		target = get_node(targetp)
	global_transform = target.global_transform
	global_position = Vector2(round(global_position.x),round(global_position.y))
	
