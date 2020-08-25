extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var game_started = false
var exited = false

var number_of_items = 0
var number_of_items_destroyed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("start_game", self, "start_game")
	Signals.connect("item_created", self, "item_created")
	Signals.connect("item_destroyed", self, "item_destroyed")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func item_created():
	number_of_items += 1
	pass
	
func item_destroyed():
	number_of_items_destroyed += 1
	pass

func start_game():
	game_started = true
	for area in get_overlapping_areas():
		if area.is_in_group("player"):
			_on_sleep_node_area_entered(area)
	pass

func _on_sleep_node_area_entered(area):
	if area.is_in_group("player") and game_started:
		Signals.emit_signal("zoom_in")
		yield(Signals, "zoom_finished")
		if exited:
			get_parent().get_node("black_fade").play("end_animation")
			get_parent().get_node("Camera2D/destroyed").text = "You've destroyed " + String(number_of_items_destroyed) + " out of " + String(number_of_items) + " destroyable things"
			Signals.emit_signal("zoom_out")
		area.go_to_sleep()
	pass # Replace with function body.

func _on_sleep_node_area_exited(area):
	if area.is_in_group("player"):
		exited = true
		Signals.emit_signal("zoom_out")
		yield(Signals, "zoom_finished")
	pass # Replace with function body.
	
