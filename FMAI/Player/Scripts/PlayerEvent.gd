extends Resource

signal FinalDeath

func onFinalDeath():
	print("FinalDeath signal emitted")
	emit_signal("FinalDeath")