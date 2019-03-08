extends Spatial

var moveDirection = Vector3()
var shell
var speed = 0

func _ready():
	set_process(false)

func lookAt(node,direction):
	node.look_at(direction,Vector3(0,1,0))

func move(shell,speed,direction):
	self.shell = shell
	self.speed = speed
	moveDirection = direction
	set_process(true)

func _process(delta):
	shell.translate(moveDirection * delta * speed)