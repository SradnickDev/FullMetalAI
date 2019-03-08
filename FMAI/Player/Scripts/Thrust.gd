extends MeshInstance

export(float,0,90) var rotationTilt = 10
export(float) var dampTime = 10

func _ready():
	rotationTilt = deg2rad(rotationTilt)

#Based on given Velocity calculate rotation with bounds.
func calcThrust(velocity,delta):
	if velocity.z < 0:
		rotation = damp(rotation,Vector3(-rotationTilt,0,0),dampTime,delta)	
	elif velocity.z > 0:
		rotation = damp(rotation,Vector3(rotationTilt,0,0),dampTime,delta)
	elif velocity.x < 0:
		rotation = damp(rotation,Vector3(0,0,rotationTilt),dampTime,delta)
	elif velocity.x > 0:
		rotation = damp(rotation,Vector3(0,0,-rotationTilt),dampTime,delta)
	else:
		rotation = damp(rotation,Vector3(0,0,0),dampTime,delta)

func damp(start,end,dampTime,delta):
	return start.linear_interpolate(end,1 - exp(-dampTime * delta))