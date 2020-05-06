extends Control



func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		self.visible = !self.visible
		
		if self.visible:
			$MenuPanel/BottomButtons/Resume.grab_focus()
			pause_mode = Node.PAUSE_MODE_PROCESS
		else:
			pause_mode = Node.PAUSE_MODE_INHERIT
			
		get_tree().paused = !get_tree().paused

func onResumeButtonPressed():
	get_tree().paused = !get_tree().paused
	self.visible = !self.visible

func onRestartButtonPressed():
	MetaData.reset()
	get_tree().paused = false
	get_tree().reload_current_scene()

func onQuitButtonPressed():
	get_tree().paused = false
	get_tree().change_scene("res://Menu/MapSelect/MapSelect.tscn")