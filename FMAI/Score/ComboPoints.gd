extends Label

export(float) var comboTime = 3
export(int) var maxCombo = 5

var multiplier = 1
var currentCombo = 0
var currentComboTime = 0

var scoreCount setget setScoreCount

func _ready():
	LazyLink.linkIt(self)
	set_process(false)
	$ComboBar.min_value = 0
	$ComboBar.max_value = comboTime
	setTimer()

func setScoreCount(res):
	scoreCount = res
	scoreCount.connect("addKillPoint",self,"onAddKillPoint")
	
func onAddKillPoint(value):
	currentCombo = clamp(currentCombo + value,  0 , maxCombo)
	multiplier = currentCombo * 10
	scoreCount.comboPoints += (1 * multiplier)
	scoreCount.killCombo = currentCombo
	set_process(true)
	$ComboTimer.start()

func _process(delta):
	text = str(currentCombo)
	$ComboBar.value = $ComboTimer.time_left

func setTimer():
	$ComboTimer.wait_time = comboTime

func onComboTimerTimeout():
	multiplier = 1
	currentCombo = clamp(currentCombo - 3,0,maxCombo)
	scoreCount.killCombo = currentCombo
	text = str("x ",currentCombo)
	if currentCombo == 0:
		$ComboTimer.stop()
	else:
		$ComboTimer.start()
