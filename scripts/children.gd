extends movable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var pushing_direction = Vector2(0, 1)
export var next_move_time : float = 4
export (PackedScene) var falling_block_scene

var falling_block
var current_next_move_time = 0
var move_count = 0

var game_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("start_game", self, "start_game")
	current_next_move_time = next_move_time
	falling_block = falling_block_scene.instance()
	get_parent().call_deferred("add_child", falling_block)
	set_block_position()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_started:
		if current_next_move_time > 0:
			current_next_move_time -= delta
		else:
			if move_count == 2:
				current_next_move_time = next_move_time
				
				move_count = 0
			elif !is_moving:
				
				if move_count == 0:
					set_move(pushing_direction.x, pushing_direction.y)
				else:
					set_move(-pushing_direction.x, -pushing_direction.y)
	#				move_direction = -move_direction
	pass
	
func start_game():
	game_started = true
	pass
	
func set_move(_x, _y):
	if move_count == 0:
		set_block_position()
	move_count += 1
	.set_move(_x, _y)
	play_move()
	pass
	
func play_move():
	$animation.play("move")
	$walk_sound.play()
	pass
	
func set_block_position():
	falling_block.end_move()
	falling_block.global_position = global_position + (pushing_direction * move_value * 1.5)
	pass
