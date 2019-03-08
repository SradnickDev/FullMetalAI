extends TextureButton

class Map:
	var name = ""
	var image
	var path = ""
	
	func _init(name,image,path):
		self.name = name
		self.image = image
		self.path = path

signal mapPicked(map,btn)
signal focusEntered(name,image)
signal focusExited()

export(Texture) var mapPreview
export(String) var gameScenePath = ""
export(String) var gameName = ""

func _ready():
	if Input.get_connected_joypads().size() > 0:
		self.connect("focus_exited",self,"OnFocusExited")
		self.connect("focus_entered",self,"onFocusEntered")

func onFocusEntered():
	emit_signal("focusEntered",gameName,mapPreview)

func OnFocusExited():
	emit_signal("focusExited")

func onButtonPressed():
	MetaData.setSimpleMetaOnly(MetaData.Map,gameName)
	emit_signal("mapPicked",Map.new(gameName,mapPreview,gameScenePath),self)
	