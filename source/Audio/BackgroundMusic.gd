extends AudioStreamPlayer
 
var music = preload("res://Audio/Background/MenuAmbient.ogg")
var defaultVolume = 10

func _ready():
	self.bus = AudioServer.get_bus_name(1)
	setStream(music)
	setVolume(defaultVolume)

func setStream(stream):
	self.stream = stream

func stopStream():
	self.stop()

func startStream():
	if not self.playing:
		self.play()

func setVolume(volume):
	self.volume_db = volume