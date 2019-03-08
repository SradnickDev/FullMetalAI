extends Node

export(NodePath) var defaultWeaponPath
export(NodePath) var overclockWeaponPath
var defaultKickBackName = "Default"
var OverclockKickBackName = "Overclock"

var resourcePreloader setget setResourceLoader

onready var defaultWeapon = get_node(defaultWeaponPath)
onready var overclockWeapon = get_node(overclockWeaponPath)
onready var camera = get_viewport().get_camera()

func useWeapon(defaultInUse,overclockInUse):
	defaultWeapon.visible = defaultInUse
	overclockWeapon.visible = overclockInUse

func setResourceLoader(loader):
	defaultWeapon.loader = loader
	overclockWeapon.loader = loader

#Fires a Weapon based on parameter
func shoot(useDefault):
	if useDefault:
		if !$KickBackPlayer.is_playing():
			$KickBackPlayer.play(defaultKickBackName)
		defaultWeapon.shoot()
		camera.shake(0)
	else:
		if !$KickBackPlayer.is_playing():
			$KickBackPlayer.play(OverclockKickBackName)
		overclockWeapon.shoot()
		camera.shake(1)

#Return Fire Rate base on Overlocked Weapon or not
func getFireRate(useDefault):
	if useDefault:
		return defaultWeapon.fireRate
	else:
		return overclockWeapon.fireRate
