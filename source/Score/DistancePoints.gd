extends Node

export(float) var valueMultiplier = 0.5
var scoreCount = null

func _ready():
	LazyLink.linkIt(self)

func setScoreCount(res):
	scoreCount = res

func _process(delta):
	if scoreCount != null:
		calculateDistancePoints()
	
func calculateDistancePoints():
	var distance = MetaData.getSimpleMeta(MetaData.Distance)
	var points = distance * valueMultiplier
	scoreCount.distanceMovedPoints = points
	