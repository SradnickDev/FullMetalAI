extends "res://Weapon/Scripts/Projectile.gd"

export(float) var damage = 0
export(int) var bounceCounter = 1


func _onContact(target):
	if target.has_method("_addDamage"):
		target._addDamage(actor,damage)
		freeProjectile(true)

func _onObstacleCollision(collision):
	if collision.collider.collision_layer == ObstacleLayer:
		if bounceCounter > 0:
			bulletBounce(collision)
			look_at(translation - moveDirection,Vector3(0,1,0))
		else:
			MetaData.setSimpleMeta(MetaData.Missed,1)
			emit_signal("colliding",collision.collider)
			freeProjectile(false)

func bulletBounce(collision):
	var normal = collision.get_normal()
	var bounceDirection = moveDirection.bounce(normal)
	bounceDirection.y = 0
	moveDirection = bounceDirection
	
	$HitEffectSparkle.play()
	
	$ReflectAudio.play()
	bounceCounter -= 1