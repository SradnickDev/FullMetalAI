extends Control

var timer = null
var disabled = false

func _ready():
	set_process(false)

func onWaveSystemNextWaveStarts():
	if disabled: return
	$AnimationPlayer.play("Show")
	$Label.text = "Wave incomming!"
	$AnimationPlayer.queue("Hide")

func onEnemyCountZeroEnemy():
	if disabled: return
	$AnimationPlayer.play("Show")
	$Label.text = "Wave Completed"
	$AnimationPlayer.queue("Hide")

func onWaveSystemWaveDelay(timer):
	if disabled: return
	$AnimationPlayer.play("Show")
	self.timer = timer
	set_process(true)

func _process(delta):
	if disabled: return
	$Label.text = str("Next Wave in : ",stepify(timer.time_left,1))

func onWaveStartDelayTimeout():
	set_process(false)

func stop():
	$AnimationPlayer.stop(false)
	$Label.visible = false