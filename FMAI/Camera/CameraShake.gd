extends Node

const Trans = Tween.TRANS_SINE
const Ease = Tween.EASE_IN_OUT

var amplitude = Vector2()
var priority = 0
var target

onready var shakes = $Shakes.get_children()

func setTarget(target):
	self.target = target

func startShake(index):
	if index > shakes.size(): return
	var currentShake = shakes[index]
	
	$JoyShake.startShake(currentShake.duration,currentShake.amplitude)
	if currentShake.priority >= self.priority:
		self.priority = currentShake.priority
		self.amplitude = currentShake.amplitude
		
		$Duration.wait_time = currentShake.duration
		$Frequency.wait_time = 1 / float(currentShake.frequency)
		$Duration.start()
		$Frequency.start()

func shake():
	var rnd = Vector3()
	rnd.x = rand_range(-amplitude.x,amplitude.x)
	rnd.y = rand_range(-amplitude.y,amplitude.y)
	
	
	$ShakeTween.interpolate_property(target,"translation",target.translation,rnd,$Frequency.wait_time,Trans,Ease)
	$ShakeTween.start()

func reset():
	$ShakeTween.interpolate_property(target,"translation",target.translation,Vector3(),$Frequency.wait_time,Trans,Ease)
	$ShakeTween.start()
	
	priority = 0

func onFrequencyTimeout():
	shake()

func onDurationTimeout():
	reset()
	$Frequency.stop()
