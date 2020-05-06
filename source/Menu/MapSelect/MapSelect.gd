extends Control

export(PackedScene) var loadingScene

var selectedMapPath = ""
var selectedMapButton

func _ready():
	BackgroundMusic.startStream()
	
	connectSignals()
	setFocus()
	$Selection/DesolationBtn.onFocusEntered()
	$Selection/DesolationBtn.onButtonPressed()

func connectSignals():
	for child in $Selection.get_children():
		if child.has_method("onButtonPressed"):
			child.connect("focusEntered",$SelectedPreview,"onMapPreview")
			child.connect("focusExited",$SelectedPreview,"onDeselectMapPreview")
			child.connect("mapPicked",self,"setPath")
			child.connect("mapPicked",$SelectedPreview,"setMap")

func setFocus():
	$ChangeModeBtn.grab_focus()

func setPath(map,button):
	$MapSelectedAudio.play()
	setSelectedMapButton(button)
	selectedMapPath = map.path
	$PlayBtn.disabled = false
	$PlayBtn.grab_focus()

func setSelectedMapButton(button):
	
	if button != selectedMapButton:
		button.disabled = true
		
		if selectedMapButton != null:
			selectedMapButton.disabled = false
			
		selectedMapButton = button

func onLoadScene():
	if selectedMapPath == "": return
	BackgroundMusic.stopStream()
	loadingScene = loadingScene.instance()
	
	var this = get_tree().root.get_node("MapSelect")
	this.queue_free()
	get_tree().root.call_deferred("add_child",loadingScene)
	
	loadingScene.loadScene(selectedMapPath)