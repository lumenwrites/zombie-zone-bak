extends CanvasLayer

onready var score = $CenterContainer/VBoxContainer/CenterContainer/HBoxContainer/Score

func _ready():
	# For some reason exported to browser version shows null there. Why? Who knows.
	# Check to make sure it's not null.
	if Save.save_data["high_score"]:
		score.text = str(Save.save_data["high_score"])
	else:
		score.text = "0"
	print("high score ", Save.save_data["high_score"])
