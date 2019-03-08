
signal forceStopped

var direction = 0
var force = 0
var duration = 0

var timer = 0
var enabled = false

func setForce(dir,force,duration):
	self.direction = dir
	self.force = force
	self.duration = duration
	self.timer = 0
	self.enabled = true

func getForce(delta):
	if self.enabled == false: return
	
	var perc = self.timer / self.duration
	var acc = Vector3(self.direction * self.force).linear_interpolate(Vector3(0,0,0),perc)
	
	self.timer += delta
	
	if self.timer >= self.duration:
		emit_signal("forceStopped")
		self.enabled = false
	
	return acc
	