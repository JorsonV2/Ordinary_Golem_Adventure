extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var move_direction = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("area_entered", self, "_on_area_enter")
	$Area2D.add_to_group("ramp")
	pass # Replace with function body.

func _on_area_enter(area : movable):
	if area != null:
		if area.is_in_group("player") and area.on_block:
			pass
		else:
			if area.is_in_group("player"):
				area.fall()
			area.moved = true
			area.set_move(move_direction.x, move_direction.y)
			var x = global_position.x + (move_direction.x * area.move_value)
			var y = global_position.y + (move_direction.y * area.move_value)
			var x_fix = int(x + 7) / int(14) * int(14)
			var y_fix = int(y + 7) / int(14) * int(14)
			area.move_destination = Vector2(x_fix, y_fix)
			
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
