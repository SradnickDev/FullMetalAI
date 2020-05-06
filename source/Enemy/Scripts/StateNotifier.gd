extends MeshInstance

export(Color) var evaluateColor = Color(1,0,0)
export(Color) var notifiyColor = Color(1,0,0)
export(bool) var replaceThirdEmission = false
var surfaceMat
var emissionMat

var defaultColor
var defaultEmissionColor

var minVal = 0
var maxVal = 0
var curVal = 0
var notifyVal = 0

func _ready():
	duplicateMaterial()

#Duplicate #1Material - Texture and #2 which is Emission
func duplicateMaterial():
	surfaceMat = get_surface_material(0)
	emissionMat = get_surface_material(1)
	
	emissionMat = emissionMat.duplicate()
	surfaceMat = surfaceMat.duplicate()
	
	defaultColor = surfaceMat.albedo_color
	defaultEmissionColor = emissionMat.albedo_color
	
	if replaceThirdEmission:
		set_surface_material(2,emissionMat)
	
	set_surface_material(1,emissionMat)
	set_surface_material(0,surfaceMat)

func setCondition(minVal,maxVal):
	if minVal == 0:
		emissionMat.albedo_color = defaultEmissionColor 
	self.minVal = minVal
	self.maxVal = maxVal

func setCurrentValue(curVal,notify = true):
	self.curVal = curVal
	evaluateCondition(notify)

func evaluateCondition(notify):
	var perc = 1-(curVal/maxVal * 1.25)
	emissionMat.emission = emissionMat.emission.linear_interpolate(evaluateColor,perc)
	emissionMat.albedo_color = emissionMat.emission
	if notify:
		notify()

func notify():
	surfaceMat.albedo_color = defaultColor
	
	$Tween.interpolate_property(surfaceMat,"albedo_color",notifiyColor,defaultColor,0.1,Tween.TRANS_LINEAR,Tween.EASE_IN,0)
	$Tween.start()

func reset():
	emissionMat.emission = defaultEmissionColor
	emissionMat.albedo_color = defaultEmissionColor
	surfaceMat.albedo_color = defaultColor