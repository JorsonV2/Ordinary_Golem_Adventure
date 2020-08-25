tool
extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (Texture) var item_texture
export var notification = true
export var item_name = "item"
export var destroy_text = "OH NO"

var goodbye = false

var destroyed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = item_texture
	$particle.texture = item_texture
	Signals.emit_signal("item_created")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.editor_hint:
		$Sprite.texture = item_texture
		$particle.texture = item_texture
		$notification_colider.visible = notification
	pass

func _on_Area2D_area_entered(area):
	if area.is_in_group("player"):
		if $Sprite.visible:
			destroy()
	pass # Replace with function body.
	
func destroy():
	destroyed = true
	$destroy_sound.play()
	Signals.emit_signal("item_destroyed")
	Signals.emit_signal("destroy", destroy_text)
	$particle.emitting = true
	$Sprite.visible = false
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	pass

func _on_notification_colider_area_entered(area):
	if area.is_in_group("player"):
		if $Sprite.visible and notification:
			Signals.emit_signal("greating", item_name)
	pass # Replace with function body.

func _on_notification_colider_area_exited(area):
	if area.is_in_group("player"):
		if notification:
			if $Sprite.visible:
				Signals.emit_signal("farewell", item_name)
					
			else:
				if !goodbye:
					Signals.emit_signal("regret", item_name)
					goodbye = true
	pass # Replace with function body.
