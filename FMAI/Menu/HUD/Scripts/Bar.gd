extends TextureProgress

signal valueChanged(currentVal,maxVal)

func initBar(minVal,maxVal,currentVal):
	self.min_value = 0
	self.max_value = maxVal
	self.value = currentVal
	emit_signal("valueChanged",self.value,self.max_value)

func setProgress(currentVal):
	self.value = currentVal
	emit_signal("valueChanged",self.value,self.max_value)