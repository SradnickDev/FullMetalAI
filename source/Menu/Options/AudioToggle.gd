extends CheckBox

const MasterBus = "Master"
var config = ConfigFile.new()

func _ready():
	self.pressed = !AudioServer.is_bus_mute(getAudioBusIndex(MasterBus))

func onAudioToggleToggled(pressed):
	var idx = getAudioBusIndex(MasterBus)
	AudioServer.set_bus_mute(idx,!pressed)
	saveSettings(!pressed)

func getAudioBusIndex(busName):
	return AudioServer.get_bus_index(busName)

func setVolumeDB(index,value):
	AudioServer.set_bus_volume_db(index,value)

func getVolumeDB(index):
	return AudioServer.get_bus_volume_db(index)

func setState(value):
	self.pressed = value

func saveSettings(value):
	var err = config.load("user://settings.cfg")
	
	config.set_value("Options", "AudioToggle" , value)
	config.save("user://settings.cfg")