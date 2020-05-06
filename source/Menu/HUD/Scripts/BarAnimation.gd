extends AnimationPlayer

export(float)var startWarningAtPercentage = 0.4
export(String) var animationName = "Play"

func _onValuesChanged(currentValue,maxValue):
	var rate = currentValue / maxValue
	if rate <= startWarningAtPercentage:
		if !self.is_playing():
			self.play(animationName)
	else:
		if self.is_playing():
			self.stop()
			self.seek(0,true)