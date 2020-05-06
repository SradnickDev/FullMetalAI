extends Control

export(float) var modifierMultiplier = 1

onready var scoreScript = preload("res://Score/ScoreCount.gd")
onready var scoreCount = preload("res://Score/ScoreCount.res")

func _ready():
	LazyLink.linkIt(self)
	set_process(false)
	setCounter()
	set_process(true)

func setCounter():
	scoreCount.set_script(scoreScript)
	$DistancePoints.setScoreCount(scoreCount)
	$ComboPanel/ComboDisplay.setScoreCount(scoreCount)
	scoreCount.reset()
	
func _process(delta):
	claculateScore()
	var score = seperator(stepify(scoreCount.currentScore,1))
	$ScoreDisplay.text = str("Score : ",score)

func seperator(value):
	value = int(value)
	var txt = str(value)
	var mod = txt.length() % 3
	var res = ""
	for i in range(0,txt.length()):
		if i != 0 && i % 3 == mod:
			res += "."
		res += txt[i]
	return res
	
func claculateScore():
	var clearPoints = scoreCount.clearPoints
	var distancePoints = scoreCount.distanceMovedPoints
	var allComboPoints = scoreCount.comboPoints
	
	var score = clearPoints + (distancePoints + allComboPoints)
	score = score * modifierMultiplier if score > 0 else score
	scoreCount.currentScore = stepify(score,1)
	
	MetaData.setSimpleMetaOnly(MetaData.Score,scoreCount.currentScore)
