extends Camera

func _ready():
	$CameraShake.setTarget(self)

func shake(index):
	$CameraShake.startShake(index)

func mousePosition(from):
		return $MousePosition.getMousePosition(self,from)