extends "res://PowerUps/Scripts/PowerUp.gd"

export(int) var shieldCharges = 5

func _increaseState():
	target.setShieldCharge(shieldCharges)
	queue_free()