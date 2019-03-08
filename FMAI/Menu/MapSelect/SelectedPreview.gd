extends Control

var mapName =""
var mapPreview
var modeName = ""
var modeDescription =""

func onMapPreview(name,texture):
	if name == $MapName.text: return
	
	$MapPreview.texture = texture
	$MapName.text = name
	$AnimationPlayer.stop(false)
	$AnimationPlayer.play("MapShow")

func setMap(map,btn):
	mapName = map.name
	mapPreview = map.image
	$MapPreviewLabel.text = ""

func onDeselectMapPreview():
	if mapName != "":
		onMapPreview(mapName,mapPreview)
	else:
		$AnimationPlayer.clear_queue()
		$AnimationPlayer.queue("MapHide")

func onModePreview(name,description):
	if name == $ModeName.text: return
	
	$ModeName.text = name
	$ModeDescription.text = description
	$AnimationPlayer.stop(false)
	$AnimationPlayer.play("ModeShow")

func onDeselectModePreview():
	if modeName != "":
		onModePreview(modeName,modeDescription)
	else:
		$AnimationPlayer.clear_queue()
		$AnimationPlayer.queue("ModeHide")

func setMode(name,description):
	modeName = name
	modeDescription = description