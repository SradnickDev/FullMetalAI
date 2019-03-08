extends Node

signal weaponChange(weapon)

export(NodePath) var overclockPath

onready var overclock = get_node(overclockPath)

var weaponMounts = []
var currentWeapon
var currentWeaponIndex = 0
var fireRateMultiplier = 0

#register to the overclock
func _ready():
	set_process(false)
	registerWeapon()
	overclock.connect("setOverclock",self,"onActivateOverclock")
	set_process(true)

func registerWeapon():
	for weaponMount in get_children():
		if weaponMount.has_method("useWeapon"):
			weaponMounts.append(weaponMount)
			weaponMount.useWeapon(false,false)
			weaponMount.resourcePreloader = $ResourcePreloader
		
			MetaData.addWeaponMeta(weaponMounts.size()-1,MetaData.Selection)
		
			overclock.registerWeapon(weaponMount)
	changeWeapon(0)

func _process(delta):
	MetaData.setWeaponMeta(currentWeaponIndex,MetaData.Selection,delta)
	
func _input(event):
	if event is InputEventKey or event is InputEventJoypadButton or event is InputEventJoypadMotion:
		onWeaponChangeInput(event)
	
func onWeaponChangeInput(event):

	if event.is_action_pressed("Q"):
		changeWeapon(cycleThroughWeapons(-1))
	if event.is_action_pressed("E"):
		changeWeapon(cycleThroughWeapons(1))
	
	if event.is_action_pressed("MouseWheelUp"):
		changeWeapon(cycleThroughWeapons(1))
	if event.is_action_pressed("MouseWheelDown"):
		changeWeapon(cycleThroughWeapons(-1))
		
	if event.is_action_pressed("Alpha1"):
		changeWeapon(0)
	if event.is_action_pressed("Alpha2"):
		changeWeapon(1)
	if event.is_action_pressed("Alpha3"):
		changeWeapon(2)
	
func changeWeapon(weaponIndex):
	
	if currentWeapon != null:
		if currentWeaponIndex == weaponIndex: 
			return
		currentWeapon.useWeapon(false,false)
	
	currentWeaponIndex = weaponIndex
	currentWeapon = weaponMounts[currentWeaponIndex]
	currentWeapon.useWeapon(true,false)
	
	overclock.weaponChanged(currentWeapon)
	emit_signal("weaponChange",currentWeapon)
	
	setFireRate()

func setFireRate():
	var fireRate = currentWeapon.getFireRate(getActivationState())
	$FireRate.wait_time = clamp(fireRate - (fireRate * fireRateMultiplier),0.01,1)

#Fire the current Weapon if $FireRate is stopped
func shoot():
	if !$FireRate.is_stopped(): return
	
	currentWeapon.shoot(getActivationState())
	setFireRate()
	$FireRate.start()

func adjustAttackSpeed(value):
	fireRateMultiplier += value
	setFireRate()

#connects Player Function with Weapons signal
func connectSignals(target):
	for mounts in weaponMounts:
		mounts.defaultWeapon.connect("newProjectileCreated",target,"on_newProjectile")
		mounts.overclockWeapon.connect("newProjectileCreated",target,"on_newProjectile")

func cycleThroughWeapons(direction):
	return ((currentWeaponIndex + direction) % weaponMounts.size() + weaponMounts.size()) % weaponMounts.size()

func onActivateOverclock(enable):
	currentWeapon.useWeapon(!enable,enable)

func getActivationState():
	var useDefault = !overclock.isActive
	return useDefault