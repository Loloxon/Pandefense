extends Node3D

class_name Projectile

@export var speed:float=2.5
@export var rotation_speed_deg:Vector3 = Vector3(10, 0, 15)
@export var projectile_sound = load("res://audio/banana_splash_short.mp3")

var starting_position:Vector3
var target:Node3D
var lerp_pos:float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = starting_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target != null and lerp_pos < 1:
		global_position = starting_position.lerp(target.global_position, lerp_pos)
		global_rotation_degrees += rotation_speed_deg
		lerp_pos += delta * speed
		
	else:
		queue_free()

func destroy_projectile():	
	AudioManager.play_effect(projectile_sound, "projectile")
	queue_free()
