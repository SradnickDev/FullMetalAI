extends Button

signal modePicked(name,description)
signal focusEntered(name,description)
signal focusExited()

export(String) var modePath = "res://GameModes/Modes/"
export(String) var modeDescription = ""

func onFocusEntered():
	emit_signal("focusEntered",self.text,modeDescription)

func onFocusExited():
	emit_signal("focusExited")

func onButtonPressd():
	MetaData.setSimpleMetaOnly(MetaData.Mode,self.text)
	LazyLink.setPath(modePath)
	emit_signal("modePicked",self.text,modeDescription,self)