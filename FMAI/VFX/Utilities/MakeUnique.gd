extends Node

export(String) var property = ""

func _ready():
	var prop = get(property)
	if prop != null:
		var uniqueProp = prop.duplicate(DUPLICATE_USE_INSTANCING)
		set(property,uniqueProp)