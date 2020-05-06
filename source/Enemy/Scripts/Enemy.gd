extends "res://Player/Scripts/Actor.gd"

signal dropPowerUp(from)

export(float) var damagePerHit = 5
export(float) var attackRange = 10
export(float) var attackRate = 0.5
export(float,0.00,1) var shieldProbability = 0.05

var defaultY = 1
var target
var targetPosition = Vector3()
var targetInRange = false

func _initialize():
	LazyLink.linkIt(self)
	$AttackRateTimer.wait_time = attackRate
	getShield()
	$MeshInstance.setCondition(0,maxHealth)
	._initialize()

func setTarget(newTarget):
	target = newTarget

func getTarget():
	return target

func getShield():
	if randf() <= shieldProbability:
		$Shield.ignoreCharge(true)

#setup for navMesh and Target
func init(newTarget,navigation):
	$NavAgent.setNav(navigation)
	translation = $NavAgent.setPos(translation)
	target = newTarget
	defaultY = translation.y

func stun(from,duration):
	$Stun.doStun(duration,self)
	$Shield.ignoreCharge(false)
	
	if from == null: return
	from.overclock.increaseAmount()

#handle movement and attack
func _process(delta):
	if target == null || !canMove || stunned: return
	
	targetInRange = $DistanceCheck.distance(translation,target.translation,0.25,delta) <= attackRange
	
	if targetInRange:
		attack()
	else:
		direction = (translation - target.translation).normalized()
		
		$NavAgent.setStartPoint(translation)
		$NavAgent.setEndPoint(target.translation)
		
		targetPosition = $NavAgent.getTargetPosition()
		velocity = $SteeringBehaviour.process(targetPosition,velocity,speed,delta)

func _physics_process(delta):
	if target == null || targetPosition == Vector3(): return
	._physics_process(delta)
	motion(targetPosition,delta)

func attack():
	if target == null: return
	
	if $AttackRateTimer.is_stopped():
		if target.has_method("_addDamage"):
			$AttackAudio.play()
			$AttackEffect.play()
			target._addDamage(self,damagePerHit)
		$AttackRateTimer.start()

func _addDamage(from,value):
	if $Shield.hasCharge(): return
	._addDamage(from,value)
	$MeshInstance.setCurrentValue(currentHealth)

func motion(targetPosition,delta):
	velocity = move_and_slide(velocity,Vector3(0,1,0),0.05,4,0)
	look_at(Vector3(target.translation.x,0,target.translation.z),Vector3(0,1,0))
	translation.y = defaultY
	

func _onDeath(from):
	if isAlive:
		$EffectParent.decouple(get_parent())
		MetaData.setSimpleMeta(MetaData.Killed,1)
		if from != null:
			emit_signal("dropPowerUp",from)
			from.overclock.increaseAmount()
	._onDeath(from)
	queue_free()

func nukeKill():
	$EffectParent.ignoreAudio = true
	$EffectParent.decouple(get_parent())
	MetaData.setSimpleMeta(MetaData.Killed,1)
	emit_signal("death")
	queue_free()