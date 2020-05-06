extends TextureRect

export(String) var mapSelection = "res://Menu/MapSelect/MapSelect.tscn"
export(String) var option = "res://Menu/Options/Options.tscn"
export(String) var credits = "res://Menu/Credits/Credits.tscn"
export(String) var leaderboard = "res://Menu/LeaderBoard/Leaderboard.tscn"

func _ready():
	BackgroundMusic.startStream()
	$SubContent/HowToBtn.grab_focus()

func onMapSelectBtnPressed():
	changeScene(mapSelection)

func onOptionsBtnPressed():
	changeScene(option)

func onLeaderboardBtnPressed():
	changeScene(leaderboard)

func onCreditsBtnPressed():
	changeScene(credits)


func onExitBtnPressed():
	get_tree().quit()

func changeScene(targetScene):
	get_tree().change_scene(targetScene)