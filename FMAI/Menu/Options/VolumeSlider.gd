extends Control

export(String) var busName = ""
export(bool) var testSound = false
var config = ConfigFile.new()

func _ready():
	var idx = getAudioBusIndex(busName)
	$Slider.value = getVolumeDB(idx)
	
	var perc = getPercentage($Slider.value)
	$Progress.text = str(perc,"%")

func onSliderValueChanged(value):
	var idx = getAudioBusIndex(busName)
	setVolumeDB(idx,value)
	saveSettings(value)
	
	if testSound && !$TestSound.playing:
		$TestSound.bus = busName
		$TestSound.play(0)
	
	var perc = getPercentage(value)
	$Progress.text = str(perc,"%")

func getPercentage(currentValue):
	var r = $Slider.max_value - $Slider.min_value
	var startValue = currentValue - $Slider.min_value
	var perc = (startValue * 100) / r
	return int(perc)

func getAudioBusIndex(busName):
	return AudioServer.get_bus_index(busName)

func setVolumeDB(index,value):
	AudioServer.set_bus_volume_db(index,value)

func getVolumeDB(index):
	return AudioServer.get_bus_volume_db(index)

func saveSettings(value):
	var err = config.load("user://settings.cfg")
	
	config.set_value("Options", str("Volume_",busName), value)
	config.save("user://settings.cfg")

func setState(value):
	$Slider.value = value