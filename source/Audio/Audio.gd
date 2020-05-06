extends AudioStreamPlayer

func _on_HitAudio_finished():
	queue_free()

func _on_colliding(target):
	get_parent().remove_child(self)
	target.add_child(self,true)
	play()