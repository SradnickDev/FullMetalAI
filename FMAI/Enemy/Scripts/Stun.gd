extends Spatial

export(float) var defaultDuration = 0
var currentDuraion = 0
var isStunned = false
var target

func onStun():
	doStun(defaultDuration,get_parent())

func doStun(duration,target):
	
	if !isStunned:
		if $StunAudio.stream:
			$StunAudio.play()
		
		self.currentDuraion = duration if defaultDuration == 0 else defaultDuration
		self.target = target
		self.target.stunned = true
		self.target.canMove = false
		self.target.velocity = Vector3(0,0,0)
		$StunEffect.emitting = true
		isStunned = true

func isStunned():
	return isStunned

func _process(delta):
	
	if isStunned:
		currentDuraion -= delta
		if currentDuraion <= 0:
			currentDuraion = 0
			target.stunned = false
			self.target.canMove = true
			isStunned = false
			$StunEffect.emitting = false
			