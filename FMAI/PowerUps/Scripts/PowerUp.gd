extends Area

export(float) var duration = 1
onready var camera = get_viewport().get_camera()
var target

func _ready():
	LazyLink.linkIt(self)
	$Duration.wait_time = duration
	self.connect("body_entered",self,"_onBodyEntered")
	$Duration.connect("timeout",self,"_onDurationTimeout")
	$Timer.connect("timeout",self,"_onTimerTimeout")

#Check if body can pickUp this
func _onBodyEntered(body):
	if body.is_in_group("Player"):
		$EffectParent.decouple(body,true)
		$AnimationPlayer.stop()
		camera.shake(6)
		target = body
		deleteVisibiles()
		$Duration.start()
		_increaseState()

func deleteVisibiles():
	$CollisionRange.queue_free()
	$Mesh.queue_free()

#should be override to Increase states
func _increaseState():
	pass

#should be overriden to eg. delete this node
func _onDurationTimeout():
	pass

func _onTimerTimeout():
	queue_free()
