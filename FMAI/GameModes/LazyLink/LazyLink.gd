extends Node

#Example
#onready var ready = LazyLink.linkIt(self)

onready var lazyGet = preload("res://GameModes/LazyLink/LazyGet.gd")
onready var lazySet = preload("res://GameModes/LazyLink/LazySet.gd")

var filePath = "res://GameModes/Modes/Default.txt"
var defaultPath = "res://GameModes/Modes/Default.txt"
const separator = ";"

var cachedVariables = {}
var command = ""

const CommandSaveKey = "0"
const CommandLoadKey = "1"

func setPath(path):
	filePath = path
	cachedVariables = {}
	getFileInfo()

func _ready():
	getFileInfo()

#Bases on CommandKey, get all Variables and store them or load them
func linkIt(node):

	if command == CommandSaveKey:
		lazyGet.getVariables(node,filePath,separator,cachedVariables)
	elif command == CommandLoadKey:
		lazySet.setVariables(node,filePath,separator,cachedVariables)

#Check the File for a Command Key
func getFileInfo():
	var data = File.new()
	data.open(filePath,File.READ)

	#go to end of file
	data.seek_end()
	if data.get_position() > 1:
		#go to first line
		data.seek(0)
		#skip first line
		data.get_line()
		#get 2nd line
		var line = data.get_line()
		command = line[0]
	else:
		command = CommandSaveKey