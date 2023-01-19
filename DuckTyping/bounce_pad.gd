extends Node3D

@export var bounce_force := 20.0

# called when a 3D body enters the bounce pad
func _on_area_3d_body_entered(body: Node3D) -> void:
	# check if function name exists
	if "apply_central_impulse" in body:
		# call without type association needed
		body.apply_central_impulse(Vector3.UP * bounce_force)
