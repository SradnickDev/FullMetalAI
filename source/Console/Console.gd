extends Control

var enable = false
var metaCommands = {}
onready var player = get_parent().get_parent()

func _ready():
	for meta in MetaData.metaType:
		metaCommands[str(meta)] = MetaData.metaType[meta]
	
	deactivate()

func _input(event):
	if event.is_action_pressed("Console"):
		if enable:
			deactivate()
		else:
			activate()

func activate():
	$Input.focus_mode = Control.FOCUS_CLICK
	$Input.grab_focus()
	$AnimationPlayer.play("Show")
	enable = true

func deactivate():
	$Input.focus_mode = Control.FOCUS_NONE
	$Input.clear()
	$Input.deselect()
	$AnimationPlayer.play("Hide")
	enable = false


func onInputTextEntered(new_text):
	evaluateCommand(new_text)

func evaluateCommand(command):
	$Input.clear()
	command = command.to_upper()
	
	if command == "FPS":
		
		$Output.print(str("FPS : ",Engine.get_frames_per_second()))
		
	elif command == "META":
		
		for meta in MetaData.metaType:
			$Output.print(meta)

	elif command.split(" ",false).size() == 2:
		
		var metaKey = command.split(" ",false)[1]
		if !metaCommands.has(metaKey): return
		var meta = MetaData.getSimpleMeta(metaCommands[metaKey])
		$Output.print(str(metaKey," : ",meta))
	
	elif command.split(" ",false).size() == 3:
		
		var line = command.split(" ",false)
		var firstKey = line[1]
		var secKey = line[2]
		
		$Output.print("Weapon Meta is in Progress")
	elif command == "CHEATS":
		
		$Output.print("GOD")
		$Output.print("DIE")
		
	elif command == "MATRIX":
		
		get_tree().paused = true
		get_parent().get_parent().pause_mode = Node.PAUSE_MODE_PROCESS
		for effect in $Matrix.get_children():
			effect.emitting = true
			
		deactivate()
		
	elif command == "START":
		
		get_tree().paused = false
		get_parent().get_parent().pause_mode = Node.PAUSE_MODE_INHERIT
		for effect in $Matrix.get_children():
			effect.emitting = false
		deactivate()
		
	elif command == "GOD":
		
		player.maxHealth = 1000000
		player._addHealth(1000000)
		deactivate()
		
	elif command == "DIE":
		
		player._addDamage(null,1000000)
		deactivate()
		
	elif command ==  "SCREEN":
		deactivate()
		
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")
		
		var screen = get_viewport().get_texture().get_data()
		var screenName = str("screen",OS.get_unix_time())
		screen.flip_y()
		var path = str("user://"+screenName+".png")
		screen.save_png(path)
		
		
	elif command == "CLEAR":
		
		$Output.clear()
		
	elif command == "?":
		
		$Output.print("FPS")
		$Output.print("META")
		$Output.print("CLEAR")
		$Output.print("MATRIX")
		$Output.print("START")
		$Output.print("SCREEN")
		$Output.print("?")
		
	else:
		$Output.print("cmd not found..")