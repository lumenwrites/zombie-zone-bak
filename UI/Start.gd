extends Spatial


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	$AnimationPlayer.play("spin")
	Input.set_custom_mouse_cursor(
		load("res://assets/icons/crossair_black.png"),
		Input.CURSOR_ARROW, Vector2(16,16)
	)


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Environment/World.tscn")
