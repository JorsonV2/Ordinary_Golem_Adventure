tool
extends Area2D

class_name static_thing
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (Texture) var texture


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = texture
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.editor_hint:
		$Sprite.texture = texture
		pass
	pass


func _on_Area2D_area_entered(area):
	if area.is_in_group("movable"):
		area.move_back(global_position)
	pass # Replace with function body.
