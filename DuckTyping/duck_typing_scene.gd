extends Node3D

@export var object : PackedScene
@export var drop_pos : NodePath


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var node := object.instantiate()
		var parent := get_node(drop_pos)
		
		parent.add_child(node)
	if event.is_action_pressed("ui_cancel"):
		var children := get_node(drop_pos).get_children()
		for c in children:
			c.queue_free()
