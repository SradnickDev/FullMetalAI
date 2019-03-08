extends CheckBox

var config = ConfigFile.new()

func _ready():
	self.pressed = OS.window_fullscreen

func onCheckBoxToggled(pressed):
	OS.window_fullscreen = pressed
	saveSettings(pressed)

func saveSettings(value):
	var err = config.load("user://settings.cfg")
	
	config.set_value("Options", "Fullscreen", value)
	config.save("user://settings.cfg")
	
func setState(value):
	self.pressed = value