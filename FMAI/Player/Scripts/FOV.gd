extends Spatial

export(float) var viewAngle = 80
export(float) var viewRadius = 50

var detectableContainer

func _ready():
	LazyLink.linkIt(self)
	for node in get_tree().get_nodes_in_group("EnemyCount"):
		detectableContainer = node

func detection():
	if detectableContainer == null: return
	for node in detectableContainer.get_children():
		if node.has_method("detected"):
			
			if global_transform.origin.distance_to(node.translation) <= viewRadius:
				var angleToNode = rad2deg(get_parent().direction.angle_to(node.direction))
				
				if abs(angleToNode) < viewAngle / 2:
					node.detected(true)
				else:
					node.detected(false)
			else:
				node.detected(false)
	