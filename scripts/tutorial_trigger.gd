extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var dialogs = []

var triggered = false

#var current_dialog = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func next_dialog():
#	if current_dialog >= dialogs.size():
#		end_tutorial()
#	else:
#		Signals.emit_signal("next_dialog", dialogs[current_dialog])
#		current_dialog += 1
#		yield(Signals, "dialog_eneded")	
#		next_dialog()
#	pass
#
#func end_tutorial():
#	Signals.emit_signal("tutorial_ended")
#	pass

func _on_tutorial_trigger_area_entered(area):
	if area.is_in_group("player") and !triggered:
		Signals.emit_signal("add_tutorial_dialogs", dialogs)
		triggered = true
#		Signals.emit_signal("tutorial_started")
#		next_dialog()
	pass # Replace with function body.
