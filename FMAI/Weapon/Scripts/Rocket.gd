extends "res://Weapon/Scripts/Projectile.gd"

export(float) var damage = 100
export(float) var radius = 3
export(float) var explosionForce = 15
export(NodePath) var areaCollisionPath
onready var areaCollision = get_node(areaCollisionPath)
var maxSpeed = 0
var timer = 0

func _ready():
	maxSpeed = speed
	speed = speed * 0.1
	$AreaCollision/CollisionShape.scale = Vector3(radius,radius,radius)
	$Tween.interpolate_property(self, 'speed',0, maxSpeed, 1, Tween.TRANS_BACK, Tween.EASE_OUT, 0)
	$Tween.start()

func _onContact(target):
	var hitted = false
	var targets = areaCollision.get_overlapping_bodies()
	if actor != null:
		$EffectParent.decouple(actor.get_parent())
	for target in targets:
		if target.has_method("_addDamage") && target.is_in_group("Enemy"):
			target._addDamage(actor,damage)
			hitted = true
			if target.has_method("addForce"):
				var dir = Vector3(target.translation - translation).normalized()
				target.addForce(dir,explosionForce,.25)
				
		freeProjectile(hitted)