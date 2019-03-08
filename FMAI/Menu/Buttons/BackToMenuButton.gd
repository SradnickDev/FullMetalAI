extends Button

export(String) var mainMenu = "res://Menu/MainMenu/MainMenu.tscn"

func onBackToMenuButtonPressed():
	get_tree().change_scene(mainMenu)