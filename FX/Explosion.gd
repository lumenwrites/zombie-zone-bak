extends Spatial

func _ready():
#	$Fire.emitting = false
#	$SmokeCloud.emitting = false
#	$Debree.emitting = false
#	$SmokeRing.emitting = false
	$Fire.one_shot = true
	$SmokeCloud.one_shot = true
	$Debree.one_shot = true
	$SmokeRing.one_shot = true
	$ExplosionAudio.play()
	global_transform.origin.y = 0 # drop it onto the ground

func explode():
	show()
	print("Explode")
	$Fire.emitting = true
	$SmokeCloud.emitting = true
	$Debree.emitting = true
	$SmokeRing.emitting = true
	$AnimationPlayer.play("explode")


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
