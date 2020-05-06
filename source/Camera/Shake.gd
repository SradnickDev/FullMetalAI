extends Node

export(float) var duration = 0
export(Vector2) var amplitude = Vector2()
export(float) var frequency = 0
export(float) var priority = 0

onready var ready = LazyLink.linkIt(self)