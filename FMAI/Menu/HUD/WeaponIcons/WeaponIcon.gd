extends TextureRect

export(Texture) var active
export(Texture) var inactive
export(Texture) var ocActive



func setActive():
	self.texture = active

func setInactive():
	self.texture = inactive

func setOCActive():
	self.texture = ocActive