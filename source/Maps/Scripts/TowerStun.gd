extends StaticBody

export(float) var cooldown = 20.1
export(float) var radius = 40
export(float) var stunDuration = 5
export(float) var EMPHitForce = 30
onready var camera = get_viewport().get_camera()

func _ready():
	set_process(false)
	LazyLink.linkIt(self)
	$DetectArea/Range.shape.radius = radius
	$Cooldown.wait_time = cooldown
	$Cooldown.one_shot = true
	$MeshInstance.setCondition(0,cooldown)

func stun(from,duration):
	if !$Cooldown.is_stopped() : return
	
	$MeshInstance.setCurrentValue(0)
	set_process(true)
	camera.shake(5)
	$ExplosionEMP.play()
	if $EMPSound.stream != null:
		$EMPSound.play()
	var targets = $DetectArea.get_overlapping_bodies()
	for target in targets:
		if target.has_method("stun"):
			target.stun(from,stunDuration)
		if target.has_method("addForce"):
			var dir = Vector3(translation - target.translation).normalized()
			target.addForce(dir,EMPHitForce,.5)
	
	$Cooldown.start()

func onCooldownTimeout():
	set_process(false)
	$MeshInstance.notify()
	$MeshInstance.reset()
