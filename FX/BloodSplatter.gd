extends Spatial


func _ready():
	$Particles1.emitting = true
	$Particles2.emitting = true
	$Particles1.one_shot = true
	$Particles2.one_shot = true
	$AudioStreamPlayer3D.play()
	yield(get_tree().create_timer(5), "timeout")
	queue_free()
