extends Spatial

onready var HUD = get_node("/root/World/HUD")
onready var camera = $"../CameraRig"

export (int) var max_health = 100
var current_health = 100

export (int) var max_armor = 100
var current_armor = 0

func _ready():
	HUD.update_healthbar(current_health)
	HUD.update_armorbar(current_armor)

func take_damage(damage):
	if current_armor > 0:
		current_armor -= damage
		HUD.update_armorbar(current_armor)
		return
	if current_health > 0:
		current_health -= damage
		HUD.update_healthbar(current_health)
		HUD.pain_effect()
		camera.shake_strength += 0.1
		if current_health <= 0: 
			print("Die")
			get_tree().change_scene("res://UI/Start.tscn")

func gain_health(value):
	if current_health == 100: return
	current_health += value
	current_health = min(current_health, 100)
	HUD.update_healthbar(current_health)
	return true # to let the health pickup know that I have picked it up so it could queue_free()

func gain_armor(value):
	print("gain armor")
	if current_armor == 100: return
	current_armor += value
	current_armor = min(current_armor, 100)
	HUD.update_armorbar(current_armor)
	return true # to let the armor pickup know that I have picked it up so it could queue_free()
