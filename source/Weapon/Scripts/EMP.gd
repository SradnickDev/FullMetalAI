extends "res://Weapon/Scripts/Projectile.gd"

export(float) var stunDuration = 0
export(float) var stunRadius = 3
export(float) var damage = 10
export(float) var EMPHitForce = 10
export(NodePath) var areaCollisionPath
onready var areaCollision = get_node(areaCollisionPath)
var hitted = false

func _ready():
	$AreaCollision/CollisionShape.scale = Vector3(stunRadius,stunRadius,stunRadius)

func _onContact(target):
	var targets = areaCollision.get_overlapping_bodies()
	emp(target)
		
	for t in targets:
		emp(t)
	freeProjectile(hitted)
	if hitted:
		$EffectParent.decouple(get_parent())

func emp(target):
	if target.has_method("stun"):
		target.stun(actor,stunDuration)
		
	if target.has_method("_addDamage"):
		target._addDamage(actor,damage)
		hitted = true
	if target.has_method("addForce"):
		var dir = Vector3(translation - target.translation).normalized()
		target.addForce(dir,EMPHitForce,.5)