extends CheckBox

var config = ConfigFile.new()

func _ready():
	self.pressed = OS.vsync_enabled

func onCheckBoxToggled(pressed):
	OS.vsync_enabled = pressed
	saveSettings(pressed)

func saveSettings(value):
	var err = config.load("user://settings.cfg")
	
	config.set_value("Options", "Vsync", value)
	config.save("user://settings.cfg")

func setState(value):
	self.pressed = value