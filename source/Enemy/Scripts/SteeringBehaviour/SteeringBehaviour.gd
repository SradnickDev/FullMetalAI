extends Spatial

var steering = Vector3()


func process(tarPos,velocity,maxVelo,delta):

	steering += $Seek.processBehaviour(tarPos,global_transform.origin,velocity,maxVelo)
	steering += $ComfortZone.saveComfortZone(delta)
	
	steering = truncate(steering,maxVelo)
	return Vector3(steering.x,0,steering.z)
	
func truncate(vec,vel):
	if vec.length() > vel:
		vec = vec.normalized() * vel
	return vec