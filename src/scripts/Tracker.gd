tool

extends Node2D


export var targetp : NodePath
var target : Node2D


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if !target:
		target = get_node(targetp)
	global_transform = target.global_transform


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
