extends TextureRect

const Settings = "user://settings.cfg"
const Section = "Options"
const Fullscreen = "Fullscreen"
const VSync = "Vsync"
const VFX = "Volume_FVX"
const Music = "Volume_Music"
const Toggle = "AudioToggle"

export(String) var mainMenuPath = ""

var config = ConfigFile.new()

func _enter_tree():
	loadConfig()

func _input(event):
	if event is InputEventKey or event is InputEventJoypadButton or event is InputEventMouseButton or event is InputEventJoypadMotion:
		if event.pressed:
			get_tree().change_scene(mainMenuPath)

func loadConfig():
	var err = config.load(Settings)
	
	
	var windowMode = config.get_value(Section,Fullscreen, true)
	
	if config.has_section_key(Section,VSync):
		var vSync = config.get_value(Section,VSync, false)
		OS.vsync_enabled = vSync
		
	if config.has_section_key(Section,VFX):
		var vfxVolumeValue = config.get_value(Section,VFX, -25)
		setVolumeDB(getAudioBusIndex("VFX"),vfxVolumeValue)
	
	if config.has_section_key(Section,Music):
		var musicVolumeValue = config.get_value(Section,Music, -25)
		setVolumeDB(getAudioBusIndex("Music"),musicVolumeValue)
	
	if config.has_section_key(Section,Toggle):
		var masterVolumeToggle = config.get_value(Section,Toggle, true)
		AudioServer.set_bus_mute(getAudioBusIndex("Master"),masterVolumeToggle)

func getAudioBusIndex(busName):
	return AudioServer.get_bus_index(busName)

func setVolumeDB(index,value):
	AudioServer.set_bus_volume_db(index,value)
