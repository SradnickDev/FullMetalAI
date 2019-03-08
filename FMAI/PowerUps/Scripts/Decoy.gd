extends Area

export(float) var speed = 30
export(float) var attractRange = 10
export(float) var explosionRange = 10
export(float) var explosionDamage = 500
export(float) var lifeTime = 5

var enemies = []
var defaultTarget = null

func init(direction,target):
	LazyLink.linkIt(self)
	setTarget(target)
	
	$LifeTime.wait_time = lifeTime
	$LifeTime.start()
	setRange(attractRange)

	$Engine.lookAt($Top,translation - direction)
	$Engine.move(self,speed,direction)

func setRange(rng):
	$AttractCollision.shape.radius = rng

func _process(delta):
	if $LifeTime.is_stopped(): return
	storeNearEnemies(true)

func storeNearEnemies(changeTarget):
	for body in get_overlapping_bodies():
		var newBody = weakref(body)
		if !enemies.has(newBody):
			enemies.append(newBody)
			if changeTarget:
				setEnemyTarget(newBody,self)

func setTarget(target):
	defaultTarget = target

func setEnemyTarget(enemy,newTarget):
	if enemy.get_ref():
		enemy.get_ref().setTarget(newTarget)

func restoreTarget():
	for enemy in enemies:
		setEnemyTarget(enemy,defaultTarget)

func explode():
	enemies.clear()
	setRange(explosionRange)
	storeNearEnemies(false)
	$Explosion.explode(enemies,defaultTarget,explosionDamage)

func onLifeTimeTimeout():
	$EffectParent.decouple(get_parent())
	restoreTarget()
	explode()
	queue_free()