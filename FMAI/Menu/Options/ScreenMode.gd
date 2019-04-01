extends CheckBox

var config = ConfigFile.new()

func _ready():
	self.pressed = OS.window_fullscreen

func onCheckBoxToggled(pressed):
	if pressed == true:
		Screen.set_fullscreen()
	else:
		Screen.set_windowed()

	saveSettings(pressed)

func saveSettings(value):
	var err = config.load("user://settings.cfg")
	
	config.set_value("Options", "Fullscreen", value)
	config.save("user://settings.cfg")
	
func setState(value):
	self.pressed = value