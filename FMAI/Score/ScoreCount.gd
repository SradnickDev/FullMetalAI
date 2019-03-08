extends Resource

signal addKillPoint(value)
var scoreCount

var currentScore = 0
var clearPoints = 0
var distanceMovedPoints = 0
var comboPoints = 0
var killCombo = 0

func addClearPoint(value):
	clearPoints = 10 * value

func addKill(value = 1):
	emit_signal("addKillPoint",value)

func reset():
	currentScore = 0
	distanceMovedPoints = 0
	comboPoints = 0
	killCombo = 0