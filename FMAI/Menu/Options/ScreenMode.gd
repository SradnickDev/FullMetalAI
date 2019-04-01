extends CheckBox

var config = ConfigFile.new()

func _ready():
	
	if OS.window_size.x == 1920:
		self.pressed = OS.window_fullscreen
	else:
		self.pressed = OS.window_maximized

func onCheckBoxToggled(pressed):
	
	if OS.window_size.x == 1920:
		OS.window_fullscreen = pressed
	else:
		OS.window_fullscreen = false
		OS.window_borderless = pressed
		OS.window_maximized = !pressed
		

	saveSettings(pressed)

func saveSettings(value):
	var err = config.load("user://settings.cfg")
	
	config.set_value("Options", "Fullscreen", value)
	config.save("user://settings.cfg")
	
func setState(value):
	self.pressed = value