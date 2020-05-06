extends Node

var weightedObjects = []

func _ready():
	randomize()
	getAllWeightedObjects()

func getAllWeightedObjects():
	weightedObjects = get_children()

# iterate through all weights and generates a random weight between 0 totalMass
# returns the Object based on weight
func getWeightedObject():
	return getRandomWeightedObject()

func getRandomWeightedObject():
	var totalMass = addAllWeights(weightedObjects)
	
	var randVal = rand_range(0, totalMass)
	var total = 0
	for weightedObject in weightedObjects:
		total += weightedObject.weight
		if total > randVal:
			return weightedObject.targetObject


func addAllWeights(weights):
	var totalMass = 0
	for i in range(weights.size()):
		totalMass += weights[i].weight
	return totalMass