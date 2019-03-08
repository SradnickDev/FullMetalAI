extends "res://PowerUps/Scripts/PowerUp.gd"

export(PackedScene) var decoy

func _increaseState():
	var decoy = self.decoy.instance()
	get_parent().add_child(decoy)
	decoy.global_transform.origin = global_transform.origin
	var direction = (global_transform.origin - target.global_transform.origin).normalized()
	decoy.init(Vector3(direction.x,0,direction.z),target)
	queue_free()