extends Spatial

export(AudioStream) var hit_sound


var right_arm = false
export var fire_rate = 0.175
export var damage = 20
export var speed_modifier = 1.25
var can_fire = true

onready var parent = get_parent().get_parent()

func _ready():
	parent.speed *= speed_modifier

func _exit_tree():
	parent.speed /= speed_modifier


func _physics_process(delta):
	if not parent is Player: return
	if Input.is_action_just_pressed("fire"):
		fire()

func fire():
	if not can_fire: return

	if right_arm: $AnimationPlayer.play("hit1")
	else: $AnimationPlayer.play("hit2")
	right_arm = !right_arm
	
	var landed_a_hit = false
	var bodies_within_range = $DamageArea.get_overlapping_bodies()
	for body in bodies_within_range:
		var is_me = body == get_parent().get_parent()
		if not is_me and body.has_method("take_damage"):
			body.take_damage(damage)
			landed_a_hit = true
	
	if landed_a_hit:
		$AudioStreamPlayer.stream = hit_sound
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stream = load("res://assets/sounds/swoosh.wav")
		$AudioStreamPlayer.play()

	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout") # wait until timer times out
	can_fire = true
