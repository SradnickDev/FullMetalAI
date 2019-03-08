extends Area

export(float) var detectionRange = 10
var target

func _ready():
	set_process(false)
	$DetectRange.shape.radius = detectionRange

func onSecurityCameraBodyEntered(body):
	target = body
	$Camera/Laser.visible = true
	set_process(true)

func onSecurityCameraBodyExited(body):
	set_process(false)
	target = null
	$Camera/Laser.visible = false

func _process(delta):
	var distToTarget = self.translation.distance_to(target.translation)
	$Camera/Laser.scale.x = distToTarget - 1
	$Camera.look_at(target.translation,Vector3(0,1,0))
	var rotX = $Camera.rotation.x
	rotX = clamp(rotX,-80,0)
	