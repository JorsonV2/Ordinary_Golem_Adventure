extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("zoom_in", self, "play_zoom_in")
	Signals.connect("zoom_out", self, "play_zoom_out")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = get_parent().find_node("player").global_position
	pass
	
func play_zoom_in():
	get_tree().get_root().get_node("game").find_node("camera_zoom").play("zoom")
	pass
	
func play_zoom_out():
	if get_tree() != null:
		get_tree().get_root().get_node("game").find_node("camera_zoom").play_backwards("zoom")
	pass

func _on_camera_zoom_animation_finished(anim_name):
	Signals.emit_signal("zoom_finished")
	pass # Replace with function body.
