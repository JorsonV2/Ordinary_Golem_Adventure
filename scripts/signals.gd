extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal greating(text)
signal farewell(text)
signal regret(text)
signal destroy(text)
signal zoom_in
signal zoom_out
signal zoom_finished
signal falled_asleep
signal tutorial_started
signal tutorial_ended
signal next_dialog(text)
signal dialog_eneded
signal start_game
signal add_tutorial_dialogs(array)
signal item_destroyed
signal item_created


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
