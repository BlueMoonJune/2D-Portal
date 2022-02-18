tool

extends RayCast2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(delta):
		var norm = get_collision_normal()
		$'../Floor'.global_position = get_collision_point()
		$'../Floor'.global_rotation = -get_angle_to(norm)
