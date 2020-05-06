extends Control

signal openMenu

func _ready():
	self.visible = false

func openMenu():
	$BackgroundPanel/Buttons/Leaderboard.grab_focus()
	MetaData.calculateMeta()
	$BackgroundPanel/Stats.setStats()
	self.visible = true
	$BackgroundPanel/Score.text = str("Score : ",MetaData.getSimpleMeta(MetaData.Score))
	emit_signal("openMenu")
	get_tree().paused = true

func onRestartButtonPressed():
	MetaData.reset()
	get_tree().paused = false
	get_tree().reload_current_scene()

func onBackToMenuButtonPressed():
	MetaData.reset()
	get_tree().paused = false
	get_tree().change_scene("res://Menu/MainMenu/MainMenu.tscn")

func onLeaderBoardButtonPressed():
	$BackgroundPanel.visible = !$BackgroundPanel.visible
	$Leaderboard.visible = !$Leaderboard.visible
	if $Leaderboard.visible:
		$Leaderboard/Buttons/Back.grab_focus()
	else:
		$BackgroundPanel/Buttons/Leaderboard.grab_focus()