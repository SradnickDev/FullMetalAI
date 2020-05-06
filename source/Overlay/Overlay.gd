extends TextureRect

func show(duration = 0.25, percentage = 1):
	modulate = Color(1,1,1,percentage)
	if !$Tween.is_active:
		$Tween.interpolate_property(self,"modulate",Color(1,1,1,percentage),Color(1,1,1,0),duration,Tween.TRANS_LINEAR,Tween.EASE_IN,0)
		$Tween.start()

func popUp(percentage = 1):
	modulate = Color(1,1,1,percentage)

func disable():
	$Tween.stop_all()
	modulate = Color(1,1,1,0)