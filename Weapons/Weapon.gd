extends Spatial

const BULLET = preload("res://Weapons/Bullet.tscn")

export var clip_size = 15
export var fire_rate = 0.12
export var reload_rate = 1.0
export var spread = 3
export var damage = 20
export var bullet_speed = 30 # I want to make it faster for the sniper rifle
export var speed_modifier = 1.0
var can_fire = true
var is_reloading = false

onready var switcher = get_parent()
onready var muzzle = $Muzzle
onready var audio_empty = $AudioEmpty
onready var audio_fire = $AudioFire
onready var audio_reload = $AudioReload
onready var animation = $AnimationPlayer
onready var parent = get_parent().get_parent()

func _ready():
	parent.speed *= speed_modifier

func _exit_tree():
	parent.speed /= speed_modifier
	
func _physics_process(delta):
	if not parent is Player: return
	if Input.is_action_pressed("fire"): 
		fire()
	if Input.is_action_just_pressed("reload"): 
		reload()
		
func fire():
	if not can_fire: return
	if is_reloading: return
	if switcher.get("clip_ammo") == 0:
		reload()
		return

	spread()
	spawn_bullet()
	switcher.spend_clip_ammo()
	animation.play("shoot")
	audio_fire.play()

	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout") # wait until timer times out
	can_fire = true

func spread():
	muzzle.rotation = Vector3(0,0,0)
	muzzle.rotate_x(deg2rad(rand_range(-spread,spread)))
	muzzle.rotate_y(deg2rad(rand_range(-spread,spread)))

func spawn_bullet():
	var instance = BULLET.instance()
	instance.global_transform = muzzle.global_transform
	instance.damage = damage
	instance.speed = bullet_speed
	instance.parent = get_parent().get_parent() # So I could make bullets ignore one who's shooting them
	get_node("/root/World").add_child(instance)

func reload():
	if is_reloading: return
	if switcher.get("clip_ammo") == clip_size: return
	if switcher.get("ammo") == 0:
		audio_empty.play()
		return

	animation.play("reload")
	is_reloading = true
	yield(get_tree().create_timer(reload_rate), "timeout")
	is_reloading = false
	
	switcher.spend_ammo(clip_size) 
	switcher.set("clip_ammo",clip_size)
	audio_reload.play()
	