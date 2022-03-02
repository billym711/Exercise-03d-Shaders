extends Node2D

export (String) var color
var is_matched
var is_counted
var selected = false
var target_position = Vector2.ZERO

var Effects = null
var dying = false
var wiggle = 0.0
export var wiggle_amount = 3

export var transparent_time = 1.0
export var scale_time = 1.5
export var rot_time = 1.5

var sound_1 = null
var sound_2 = null
var sound_3 = null


func _ready():
	$Select.texture = $Sprite.texture
	$Select.scale = $Sprite.scale

func _physics_process(_delta):
	if dying and not $Tween.is_active():
		queue_free()
		
	elif position != target_position:
		position = target_position
	if selected:
		$Select.show()
		$Selected.emitting = true
	else:
		$Select.hide()
		$Selected.emitting = false


func generate(pos):
	position = Vector2(pos.x,-100)
	target_position = pos
	if sound_1 == null:
		sound_1 = get_node_or_null("/root/Game/1")
	if sound_1 != null:
		sound_1.play()

func move_piece(change):
	target_position = target_position + change
	if sound_2 == null:
		sound_2 = get_node_or_null("/root/Game/2")
	if sound_2 != null:
		sound_2.play()
func die():
	if Effects == null:
		Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		get_parent().remove_child(self)
		Effects.add_child(self)
		$Timer.wait_time = 0.5 + (randf() / 10.0)
		$Timer.start()
		$Tween.interpolate_property(self, "modulate:a", 1, 0, transparent_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()
		$Tween.interpolate_property(self, "scale", scale, Vector2(3,3), scale_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()
		$Tween.interpolate_property($Sprite, "rotation",rotation, (randf()*4*PI)-2*PI, rot_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()
	dying = true;
	if sound_3 == null:
		sound_3 = get_node_or_null("/root/Game/3")
	if sound_3 != null:
		sound_3.play()
	if Effects == null:
		Effects = get_node_or_null("/root/Game/Effects")



func _on_Timer_timeout():
	if Effects == null:
		Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		dying = true;



func _on_Timer2_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randi_range(1,6)
	if my_random_number == 1:
		if $Sprite.texture == load("res://Assets/chick.png"):
			$Sprite.set_texture(preload("res://Assets/chick_blink.png"))
	if my_random_number == 2:
		if $Sprite.texture == load("res://Assets/duck.png"):
			$Sprite.set_texture(preload("res://Assets/duck_blink.png"))
	if my_random_number == 3:
		if $Sprite.texture == load("res://Assets/elephant.png"):
			$Sprite.set_texture(preload("res://Assets/elephant_blink.png"))
	if my_random_number == 4:
		if $Sprite.texture == load("res://Assets/parrot.png"):
			$Sprite.set_texture(preload("res://Assets/parrot_blink.png"))
	if my_random_number == 5:
		if $Sprite.texture == load("res://Assets/sloth.png"):
			$Sprite.set_texture(preload("res://Assets/sloth_blink.png"))
	if my_random_number == 6:
		if $Sprite.texture == load("res://Assets/zebra.png"):
			$Sprite.set_texture(preload("res://Assets/zebra_blink.png"))

	$Timer3.start()


func _on_Timer3_timeout():
	if $Sprite.texture == load("res://Assets/chick_blink.png"):
		$Sprite.set_texture(preload("res://Assets/chick.png"))
	if $Sprite.texture == load("res://Assets/duck_blink.png"):
		$Sprite.set_texture(preload("res://Assets/duck.png"))
	if $Sprite.texture == load("res://Assets/elephant_blink.png"):
		$Sprite.set_texture(preload("res://Assets/elephant.png"))
	if $Sprite.texture == load("res://Assets/parrot_blink.png"):
		$Sprite.set_texture(preload("res://Assets/parrot.png"))
	if $Sprite.texture == load("res://Assets/sloth_blink.png"):
		$Sprite.set_texture(preload("res://Assets/sloth.png"))
	if $Sprite.texture == load("res://Assets/zebra_blink.png"):
		$Sprite.set_texture(preload("res://Assets/zebra.png"))
