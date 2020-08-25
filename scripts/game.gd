extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text

var tutorial_dialogs = []
var tutorial_dialog_playing = false

var start_pixel = null
var pixel_changed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("next_dialog", self, "next_tutorial_dialog")
	Signals.connect("add_tutorial_dialogs", self, "add_tutorial_dialogs")
	$black_fade.play("fix")
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !pixel_changed:
		var data = get_viewport().get_texture().get_data()
		data.lock()
		var pixel = data.get_pixel(0, 0)
		data.unlock()
		
		if(start_pixel == null):
			start_pixel = pixel
		elif(start_pixel != pixel):
			pixel_changed = true
			start_game()
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		pass
	if tutorial_dialogs.size() > 0 and !tutorial_dialog_playing:
		tutorial_dialog_playing = true
		play_tutorial_dialog()
		pass
	pass
	
func start_game():
	$beggining_animation.play("fade")
	$black_fade.play("fade")
	$main_music.play()
	pass
	
func add_tutorial_dialogs(array):
	for dialog in array:
		tutorial_dialogs.append(dialog)
	pass

func play_tutorial_dialog():
	find_node("tutorial_text").text = tutorial_dialogs[0]
	tutorial_dialogs.pop_front()
	$tutorial_animator.play("one_dialog")
	pass

func next_tutorial_dialog(dialog):
	
	
	pass

func _on_tutorial_animator_animation_finished(anim_name):
	tutorial_dialog_playing = false
	pass # Replace with function body.

func _on_TextureButton_pressed():
	Signals.emit_signal("start_game")
	$beggining_animation.play_backwards("fade")
	pass # Replace with function body.
