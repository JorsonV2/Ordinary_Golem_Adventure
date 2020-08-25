extends movable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var move_table = []
export var rest_time = 0.4
export var resting = true

var reached_goal = false
var current_move = 0
var current_rest_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("falled_asleep", self, "stop_resting")
	pass # Replace with function body.

func _process(delta):
	if !is_moving and !resting and current_rest_time <= 0:
		if reached_goal:
			set_move(-move_table[current_move].x, -move_table[current_move].y)
			current_move -= 1
			if current_move < 0:
				current_move = 0
				resting = true
				reached_goal = false
			pass
		else:
			set_move(move_table[current_move].x, move_table[current_move].y)
			current_move += 1
			if current_move == move_table.size():
				current_move -= 1
				reached_goal = true
			pass
		pass
	elif current_rest_time > 0:
		current_rest_time -= delta
	pass
	
func stop_resting():
	resting = false
	pass
	
func set_move(x, y):
	if !resting:
		.set_move(x, y)
		current_rest_time = rest_time
		play_move()
	pass
	
func play_move():
	$animation.play("move")
	$walk_sound.play()
	pass
