extends "res://Enemy/Scripts/Enemy.gd"

export(float) var explosionRange = 10
export(float) var explosionDamage = 8
export(float) var explosionForce = 10
var collisionArea
var collision

func _initialize():
	
	collisionArea = $ExplosionArea
	$ExplosionArea/ExplosionCollision.shape.radius = explosionRange
	._initialize()

#check for distance
#if in range Explode
func _process(delta):
	if target == null: return
	var dist = $DistanceCheck.distance(translation,target.translation,0.2,delta)
	if dist < attackRange:
		explosion()

#get all bodies in collisionArea and add damage if possible
func explosion():
	var targets = collisionArea.get_overlapping_bodies()
	$EffectParent.decouple(get_parent())
	for t in targets:
		if t.has_method("addDamage") && not t.is_in_group("Enemy"):
			print("Adddamage")
			t.addDamage(self,explosionDamage)
	_onDeath(null)