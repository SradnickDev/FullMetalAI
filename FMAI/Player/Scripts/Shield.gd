extends Node

var charge = 0
var ignoreCharge = false

func ignoreCharge(value):
	ignoreCharge = value
	if ignoreCharge: showShieldEffect(true)
	else: showShieldEffect(false)

func setCharge(charge):
	self.charge = charge
	if charge > 0: showShieldEffect(true)
	ignoreCharge = false
	
func showShieldEffect(value):
	$AnimationPlayer.play("Play")
	$ShieldEffect.visible = value
	
func decreaseCharge():
	if !ignoreCharge:
		charge = clamp(charge - 1,0,100)
		if charge == 0: showShieldEffect(false)

func hasCharge():
	return ignoreCharge == true || charge > 0