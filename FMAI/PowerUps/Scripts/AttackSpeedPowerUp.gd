extends "res://PowerUps/Scripts/PowerUp.gd"

export(float,0.00,1) var fireRateMultiplier = 0.25

func _increaseState():
	target.topPart.adjustAttackSpeed(fireRateMultiplier)

func _onDurationTimeout():
	target.topPart.adjustAttackSpeed(-fireRateMultiplier)