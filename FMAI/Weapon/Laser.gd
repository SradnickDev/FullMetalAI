extends Spatial

export(float) var length = 50

func _ready():
	$RayCast.cast_to = Vector3(0,0,length)
	$MeshInstance.scale.x = length

func _process(delta):
	
	if $RayCast.is_colliding():
		var hitPoint = $RayCast.get_collision_point()
		var distToPoint = translation.distance_to(hitPoint)
		$MeshInstance.scale.x = distToPoint / 2
	else:
		if $MeshInstance.scale.x != length:
			$MeshInstance.scale.x = length