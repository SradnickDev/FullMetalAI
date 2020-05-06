extends Node

export(bool) var setDefault = false
export(int) var overrideWave = 0
export(int) var increasePerWave = 0
export(int) var defaultAmount = 10
export(float) var timeBetweenSpawn = 1
export(float) var randomSpawnRange = 1

onready var ready = LazyLink.linkIt(self)

#Retrieves a Enemy
func getEnemy():
	return $WeightedObject.getWeightedObject()