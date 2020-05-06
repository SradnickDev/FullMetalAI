extends StaticBody

export(float) var radius = 40
export(float) var maxPushForce = 10
export(float) var stunDuration = 5
export(float) var EMPHitForce = 5

onready var camera = get_viewport().get_camera()

var applyForce = false
var currentForce = 0
var target = null

func _ready():
	$TowerEffect.scale = Vector3(radius,0,radius)
	$SafeZone/Range.shape.radius = radius
	
func _process(delta):
	if target == null: return
	useForce(delta)

func useForce(delta):
	var forceDir = (translation - target.translation).normalized()
	if applyForce:
		currentForce = clamp(currentForce + delta * 10,0,maxPushForce)
	else:
		currentForce = clamp(currentForce - delta * 10,0,maxPushForce)
	target.velocity += forceDir * currentForce

func _on_SafeZone_body_entered(body):
	if body == target:
		applyForce = false

func _on_SafeZone_body_exited(body):
	if body.has_method("addForce"):
		target = body
		$WarningSound.play(0)
		applyForce = true
