extends "res://PowerUps/Scripts/PowerUp.gd"

export(float) var speed = 5

func _increaseState():
	target.adjustSpeed(speed)

func _onDurationTimeout():
	target.adjustSpeed(-speed)