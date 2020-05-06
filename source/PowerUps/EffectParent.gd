extends Spatial


export(bool) var ignoreAudio = false
#Remove all Children with Method "Play"
#Sets new Parent and Position
#Starts all Children
#Considered all childs are Effects,Audio - Nodes
func decouple(parent,useParentPos = false):
	
	for effect in get_children():
		if effect.has_method("play"):
			
			if effect.is_class("AudioStreamPlayer") && ignoreAudio == true:
				continue;
			
			remove_child(effect)
			parent.add_child(effect)
			
			if !effect.is_class("AudioStreamPlayer"):
				if !useParentPos:
					effect.global_transform.origin = global_transform.origin
				else:
					effect.global_transform.origin = parent.global_transform.origin
				
			effect.play()