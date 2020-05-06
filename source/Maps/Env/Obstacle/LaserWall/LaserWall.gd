extends Spatial

export(float) var damage = 10
export(bool) var useTimer = false
export(float) var switchTime = 5
export(bool) var activated = true
var destroyed = false

onready var rocket = preload("res://Weapon/Scripts/Rocket.gd")
onready var emp = preload("res://Weapon/Scripts/EMP.gd")

func _ready():
	
	$SwitchTimer.autostart = false
	$Entry.visible = activated
	LazyLink.linkIt(self)
	
	if useTimer:
		$SwitchTimer.wait_time = switchTime
		$SwitchTimer.start()

func _on_Generator_body_entered(body):
	if destroyed: return
	
	if body.get_script() == emp:
		changeState()
	if body.get_script() == rocket:
		destroyed = true
		$PlayerDamagedParticle.play()
		$Entry.visible = !destroyed

func _on_Entry_body_entered(body):
	if destroyed || !activated: return
	
	if body.has_method("_addDamage"):
		body._addDamage(null,damage)
		if body.is_in_group("Player"):
			if $HitAudio.stream:
				$HitAudio.play()
	

func changeState():
	activated = !activated
	$Entry.visible = activated
	if activated:
		var bodies = $Entry.get_overlapping_bodies()
		for body in bodies:
			_on_Entry_body_entered(body)

func _on_SwitchTimer_timeout():
	changeState()