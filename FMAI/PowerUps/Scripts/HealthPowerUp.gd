extends "res://PowerUps/Scripts/PowerUp.gd"

export(float) var increaseHealth = 20

func _increaseState():
	target._addHealth(increaseHealth)
	queue_free()