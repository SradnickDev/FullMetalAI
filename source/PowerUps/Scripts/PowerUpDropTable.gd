extends Position3D

func _ready():
	get_parent().connect("dropPowerUp",self,"onDropPowerUp")

func onDropPowerUp(from):
	
	var drop = $WeightedDrops.getWeightedObject()
	if drop == null: return
	drop = drop.instance()
	
	drop.translation = self.global_transform.origin
	from.get_parent().add_child(drop)