extends movable

var is_jumping = false
var is_sleeping = false
export var is_static = true
var has_tutorial = false
var on_block = 0

var check_point_position

func _ready():
	connect("area_exited", self, "_area_exited")
	Signals.connect("greating", self, "_greating")
	Signals.connect("farewell", self, "_farewell")
	Signals.connect("destroy", self, "_destroy")
	Signals.connect("regret", self, "_regret")
	Signals.connect("tutorial_started", self, "start_tutorial")
	Signals.connect("tutorial_ended", self, "end_tutorial")
#	go_to_sleep()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement()
	if is_moving:
		move(delta)
	if Input.is_action_pressed("check_point"):
		load_check_point()
	pass
	
func load_check_point():
	if check_point_position != null:
		end_move()
		global_position = check_point_position
	pass
	
func end_move():
	.end_move()
	is_jumping = false
	for area in get_overlapping_areas():
		if area.is_in_group("ramp"):
			area.get_parent()._on_area_enter(self)
	pass
	
func movement():
	if !is_static and !has_tutorial and !is_sleeping and !is_moving and (is_overlaping_something_special() or on_block or Input.is_action_pressed("grab")):
		if Input.is_action_just_pressed("left"):
			set_move(-1, 0)
		elif Input.is_action_just_pressed("right"):
			set_move(1, 0)
		elif Input.is_action_just_pressed("up"):
			set_move(0, -1)
		elif Input.is_action_just_pressed("down"):
			set_move(0, 1)
		if on_block:
			if is_moving:
				move_destination = global_position + (move_direction * move_value * 2)
				play_climb()
			
#		move_destination = move_destination.floor()
#		move_start_position = move_start_position.floor()
	pass

func is_overlaping_something_special():
	for area in get_overlapping_areas():
		if !area.is_in_group("can_overlap"):
			return false
	return true
	pass

func set_move(x, y):
	.set_move(x, y)
	if !moved:
		play_move()
#		if Input.is_action_pressed("grab"):
#			play_climb()
	else:
		wake_up()
	pass

func fall():
	$Sprite.position = Vector2(0,0)
	$animation.play("fall")
	$fall_sound.play()
	pass
	
func play_move():
	$animation.stop(true)
	$animation.play("move")
	$walk_sound.play()
	pass
	
func play_climb():
	$climb_animation.play("climb")
	$jump_sound.play()
	pass
	
func go_to_sleep():
	for area in get_overlapping_areas():
		if area.is_in_group("sleep_node"):
			is_sleeping = true
			$zzz.visible = true
			$sleep_animation.play("sleep")
			Signals.emit_signal("falled_asleep")
	pass
	
func wake_up():
	if is_sleeping:
		is_sleeping = false
		is_static = false
		$zzz.visible = false
		$sleep_animation.stop(true)
		Signals.emit_signal("zoom_out")
	pass
	
func _greating(item_name):
	say_something("What's up " + item_name)
	pass
	
func _farewell(item_name):
	say_something("Bye bye " + item_name)
	pass
	
func _destroy(text):
	say_something(text)
	pass
	
func _regret(item_name):
	say_something("Poor " + item_name)
	pass
	
func say_something(text):
	$Label.text = text
	$label_animator.stop(true)
	$label_animator.play("say_something")
	pass
	
func start_tutorial():
	has_tutorial = true
	pass
	
func end_tutorial():
	has_tutorial = false
	pass	
	
func _area_entered(area):
	if area != null:
		if !Input.is_action_pressed("grab") and !on_block:
			._area_entered(area)
		elif area.is_in_group("block") and !moved:
#			print_debug("get_on_block")
			play_climb()
			on_block = true
			
		if area.is_in_group("check_point"):
			check_point_position = area.global_position
			area.checked = true
	pass
	
func _area_exited(area):
	if area != null:
		if area.is_in_group("block"):
			if on_block:
				on_block = false
				is_jumping = true
	pass


func _on_player_body_entered(body):
	print_debug(body.global_position + Vector2(7, 7), global_position)
#	move_back(body.global_position + Vector2(7, 7))
	pass # Replace with function body.
