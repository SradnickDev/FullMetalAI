extends Node

export(float) var force = 0.02


func processBehaviour(tarPos,curPos,velocity,maxVelo):
	
	var desired_velocity = Vector3(tarPos - curPos).normalized() * maxVelo
	var steering = Vector3()
	
	steering = desired_velocity - velocity
	steering = steering.normalized() * force

	return Vector3(steering.x,0,steering.z)