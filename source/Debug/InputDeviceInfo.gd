extends Control

class InputInfo:
	var info
	var icon

	func _init(info,icon):
		self.info = info
		self.icon = icon

export(Texture) var controllerIcon
export(Texture) var keyboardIcon

var queue = []

func _ready():
	checkInput()
	connectSignal()

func connectSignal():
	Input.connect("joy_connection_changed",self,"deviceConnected")

func checkInput():
	var count = Input.get_connected_joypads().size()
	if count > 0:
		deviceConnected(0,true)
	evaluateMouse(count)

func evaluateMouse(inputCount):
	if inputCount > 0:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func deviceConnected(index,connected):
	if connected:
		notify("disconnected",keyboardIcon)
		notify("Connected",controllerIcon)
	else:
		notify("disconnected",controllerIcon)
		notify("Connected",keyboardIcon)

func notify(info,icon):
	queue.push_back(InputInfo.new(info,icon))
	
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("Notify")
	else:
		$AnimationPlayer.queue("Notify")

func onAnimationStarted(anim_name):
	var re = queue.pop_front()
	$Info/State.text = re.info
	$Info/Icon.texture = re.icon

