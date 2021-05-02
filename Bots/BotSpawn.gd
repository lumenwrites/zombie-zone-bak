extends Position3D


var BOT = preload("res://Bots/Bot.tscn")
onready var bots = get_node("/root/World/Bots")

export var active = true
export var max_enemies = 3
export var spawn_frequency = 2.0
var can_spawn = true

func _physics_process(delta):
	if active and can_spawn and bots.get_children().size() < max_enemies:
		spawn_bot()
		can_spawn = false
		yield(get_tree().create_timer(spawn_frequency), "timeout")
		can_spawn = true


func spawn_bot():
	var instance = BOT.instance()
	instance.global_transform.origin = global_transform.origin
	randomize()
	var weapons = ["Fists", "Sword", "Gun", "Shotgun", "Assault Rifle", "Sniper Rifle", "Grenade", "Rocket Launcher", "Zombie Fists"]
	weapons = ["Fists", "Sword", "Gun", "Shotgun", "Assault Rifle", "Rocket Launcher"]
	instance.default_weapon = weapons[rand_range(0,weapons.size())]
	#instance.armored = rand_range(0,1) < 0.5
	bots.add_child(instance)
