extends Node

var nextRefresh = 0
var lastDistance

#get new distance after x amount
func distance(from,to,refreshRate,delta):
	if nextRefresh <= 0:
		lastDistance = from.distance_to(to)
		nextRefresh = refreshRate
	nextRefresh -= delta
	return lastDistance

