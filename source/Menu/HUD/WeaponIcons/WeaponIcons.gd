extends Control

var icons
var currentIcon


func init():
	if icons == null:
		icons = {"MachineGunMount":$Icons/MG,"RocketLauncherMount":$Icons/RL,"EMPGunMount":$Icons/EMP}

func onWeaponChange(weapon):
	init()
	for weaponIcon in icons.keys():
		if weaponIcon == weapon.name:
			icons[weaponIcon].setActive()
			currentIcon = icons[weaponIcon]
		else:
			icons[weaponIcon].setInactive()
	
func onOverclockUse(value):
	if value == true:
		currentIcon.setOCActive()
	else:
		currentIcon.setActive()