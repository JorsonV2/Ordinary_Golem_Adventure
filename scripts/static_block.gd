extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("block")
	pass # Replace with function body.

func _on_static_block_area_entered(area : movable):
	if area != null:
		if area.is_in_group("movable"):
#			print_debug(area)
			if area.is_in_group("player") and !Input.is_action_pressed("grab") and !area.moved:
				area.move_back(global_position)
			elif not area.is_in_group("player"):
				area.move_back(global_position)
			pass
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
