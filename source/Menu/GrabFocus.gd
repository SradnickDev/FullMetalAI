extends Control

export(NodePath) var nodePath

func _ready():
	get_node(nodePath).grab_focus()
