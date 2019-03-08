extends Area

const hardNeighborLimit = 3

export(float) var comfortZoneUpdateRate = 0.5
export(float) var seperationForce = 2
var nextProcess = 3
var comfortForce = Vector3(0,0,0)

func saveComfortZone(delta):
	return comfortForce

func onUpdateTimerTimeout():
	comfortUpdate()

func comfortUpdate():
	comfortForce = seperationBehaviour()

func seperationBehaviour():
	var force = Vector3()
	var neighborCount = get_overlapping_areas().size()
	var averageDistance = 0
	for neighbor in get_overlapping_areas():
		force.x += neighbor.global_transform.origin.x - global_transform.origin.x
		force.z += neighbor.global_transform.origin.z - global_transform.origin.z
		averageDistance += global_transform.origin.distance_to(neighbor.global_transform.origin)
	
	if neighborCount != 0:
		force.x /= neighborCount
		force.y /= neighborCount
		averageDistance /= neighborCount
		
	force.y = 0
	force = -force
	var comfortForce = force.normalized() * seperationForce
	return Vector3(comfortForce.x,0,comfortForce.z)