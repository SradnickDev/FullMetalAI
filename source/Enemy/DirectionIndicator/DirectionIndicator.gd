extends Spatial

var viewport	#Node Viewport
var camera		#Current Camera
var screenSize	#Viewport Size
var indicatorSize#Texture Size in Pixel
var borderSize = 100

func _ready():
	connectSignals()
	getViewport()
	getCamera()
	getScreeSize()
	getIndicatorSize()
	disableProcess()

func connectSignals():
	$VisibilityNotifier.connect("camera_entered",self,"onVisibilityNotifierCameraEntered")
	$VisibilityNotifier.connect("camera_exited",self,"onVisibilityNotifierCameraExited")

func getViewport():
	viewport = get_viewport()

func getCamera():
	camera = viewport.get_camera()

func getIndicatorSize():
	indicatorSize = $Indicator.texture.get_size()

func getScreeSize():
	screenSize = viewport.size

func disableProcess():
	if viewport == null || camera == null:
		set_process(false)

#Update Screen Position from WorldPosition
#Look at Screen Position
#Clamp Indicator to ScreenSize, considered Indicator Size
#Set Indicator Position
func _process(delta):
	if visible:
		evaluatePosition()

func evaluatePosition():
	var screenPosition = getScreenPos()
	screenPosition = clampScreenPos(screenPosition)
	setScreenPos(screenPosition)
	
func getScreenPos():
	var screenPosition = camera.unproject_position(global_transform.origin)
	$Indicator.look_at(screenPosition)
	return screenPosition

func clampScreenPos(screenPosition):
	var maxX = screenSize.x - (indicatorSize.x / 2) - borderSize
	var minX = indicatorSize.x / 2 + borderSize
	
	
	
	var maxY = screenSize.y - (indicatorSize.y / 2) - borderSize
	var minY = indicatorSize.y / 2 + borderSize

	screenPosition.x = clamp(screenPosition.x, minX, maxX)
	screenPosition.y = clamp(screenPosition.y, minY, maxY)
	
	return screenPosition

func setScreenPos(screenPosition):
	$Indicator.position = screenPosition

func onVisibilityNotifierCameraEntered(camera):
	$Indicator.visible = false

func onVisibilityNotifierCameraExited(camera):
	$Indicator.visible = true
