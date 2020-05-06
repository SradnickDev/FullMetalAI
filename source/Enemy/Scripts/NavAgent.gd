extends Node

export(float) var pathUpdateRate = 1
export(bool) var useThreads = false
var navigation = null
var path = null

var startPosition = Vector3()
var endPosition = Vector3()
var targetPosition = Vector3()

func _ready():
	setPathUpdateRate()

func setPathUpdateRate():
	$UpdateTimer.wait_time = pathUpdateRate

func setNav(nav):
	navigation = nav
	
func setPos(pos):
	pos = navigation.get_closest_point(pos);
	return pos

func setStartPoint(startPoint):
	startPosition = startPoint

func setEndPoint(endPoint):
	endPosition = endPoint
	
func updatePath():
	if navigation == null: return
	
	if useThreads:
		navigation.addRequest(self,startPosition,endPosition)
	else:
		path = Array(navigation.get_simple_path(startPosition, endPosition, true))

func setPath(newPath):
	path = Array(newPath)

func moveOnPath():
	if path == null:
		path = []
		$UpdateTimer.start()
		updatePath()
		
	if path.size() == 0: return
	var remainDist = startPosition.distance_to(path[0])

	if remainDist <=  5 && path.size()-1 > 0:
		path.pop_front()
		targetPosition = path[0]

func getTargetPosition():
	moveOnPath()
	return targetPosition

func _on_UpdateTimer_timeout():
	updatePath()