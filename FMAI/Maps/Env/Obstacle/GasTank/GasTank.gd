extends StaticBody

export(float) var explosionRange = 10
export(float) var damage = 100

onready var rocket = preload("res://Weapon/Scripts/Rocket.gd")
onready var camera = get_viewport().get_camera()

var disabled = false

func _ready():
	LazyLink.linkIt(self)
	$Area/ExplosionRange.shape.radius = explosionRange

func onProjectileBodyEntered(body):
	if disabled: return
	
	if body.collision_layer == 4 && body.get_script() == rocket:
		$EffectParent.decouple(body.get_parent())
		explode()
		disabled = true
		$DestroyedTank.visible = true
		$MeshInstance.visible = false

func explode():
	camera.shake(3)
	var targets = $Area.get_overlapping_bodies()
	for target in targets:
		if target.has_method("_addDamage"):
			target._addDamage(null,damage)