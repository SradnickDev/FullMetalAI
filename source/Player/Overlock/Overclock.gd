extends Node

signal setOverclock(enable)
signal amountChange(currentOverclockAmount)
signal weaponChange(overclockAmount,maxPoints)
signal overclockIsEmpty

export(int) var defaultPoints = 1
export(int) var maxPoints = 10
export(float) var depletionRate = 2
export(float) var increaseAmountStep = 0.5

onready var camera = get_viewport().get_camera()

var overclockAmount = {}
var currentWeapon
var isActive = false

func _ready():
	defaultPoints = maxPoints
	get_parent().connect("useOverclock",self,"onPlayerUseOverclock")

func registerWeapon(weapon):
	LazyLink.linkIt(self)
	if overclockAmount.has(weapon): return
	overclockAmount[weapon] = defaultPoints

func weaponChanged(weapon):
	if isActive:
		$OverclockStartAudio.stop()
		$OverclockEndAudio.stop()
	$Overlay.disable()
	currentWeapon = weapon
	emit_signal("weaponChange",overclockAmount[currentWeapon],maxPoints)
	isActive = false

func _process(delta):
	decreaseAmount(delta)

func decreaseAmount(delta):
	if isActive && currentWeapon != null:
		overclockAmount[currentWeapon] = clamp(overclockAmount[currentWeapon] - delta * depletionRate , 0 , maxPoints)
		
		var perc =  clamp(1-(overclockAmount[currentWeapon]/maxPoints) ,0,1)
		$Overlay.show(0.5,perc)
		
		if overclockAmount[currentWeapon] == 0:
			overclockAmount[currentWeapon] = 0
			$Overlay.disable()
			emit_signal("setOverclock",false)
			emit_signal("overclockIsEmpty")
			camera.shake(2)
			isActive = false
			$OverclockEndAudio.play()
			
		emit_signal("amountChange",overclockAmount[currentWeapon])

func increaseAmount():
	if isActive: return
	var amount = overclockAmount[currentWeapon]
	if amount < maxPoints:
		overclockAmount[currentWeapon] += increaseAmountStep
		emit_signal("amountChange",overclockAmount[currentWeapon])

func onPlayerUseOverclock():
	if overclockAmount[currentWeapon] <= 0: return
	isActive = !isActive
	if isActive:
		emit_signal("setOverclock",true)
		$OverclockEndAudio.stop()
		$OverclockStartAudio.play()
	else:
		$Overlay.disable()
		emit_signal("setOverclock",false)
		$OverclockStartAudio.stop()
		$OverclockEndAudio.play()