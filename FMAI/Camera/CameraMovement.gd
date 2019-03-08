extends Spatial

export(Vector3) var targetOffset = Vector3(0,15,0)
export(Vector3) var additionalOffset = Vector3(0,5,3)
export(Vector3) var angle = Vector3(30,0,0)

export(float) var positionDampTime = 5
export(float) var zoomDampTime = 5

export(NodePath) var targetPath

var offset = Vector3()
var targetIsMoving = false
onready var target = get_node(targetPath)
onready var ready = LazyLink.linkIt(self)

func _ready():
	if target != null:
		setOffsetStartPosition()
		$Camera.rotation_degrees = angle

func setOffsetStartPosition():
	offset = target.translation + targetOffset
	pass

func _physics_process(delta):
	if target == null: return
	evaluateOffset(delta)
	smoothCameraToTarget(target.translation,offset,delta)

func evaluateOffset(deltaTime):
	
	if targetIsMoving:
		offset = damp(offset,targetOffset + additionalOffset,zoomDampTime,deltaTime)
	else:
		offset = damp(offset,targetOffset,zoomDampTime,deltaTime)

func onPlayerStartedMoving():
	targetIsMoving = true

func onPlayerStoppedMoving():
	targetIsMoving = false

func smoothCameraToTarget(tarPos,offset,delta):
	var target = tarPos + offset
	self.translation = damp(self.translation,target,positionDampTime,delta)

#framerate independent damping using lerp
func damp(start,end,dampTime,delta):
	return start.linear_interpolate(end,1 - exp(-dampTime * delta))