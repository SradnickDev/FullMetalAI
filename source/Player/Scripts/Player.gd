extends "res://Player/Scripts/Actor.gd"

signal useOverclock
signal pickUpPowerUp(powerUp)
signal playerDied

export(float) var overclockstunDuration = 5

const Acceleraton = 0.1
onready var overclock = $Overclock
onready var camera = get_viewport().get_camera()
onready var topPart = $WeaponGroup

var lastPosition = Vector3()
var inputDir = Vector3()
var isMoving = false

func _initialize():
	LazyLink.linkIt(self)
	lastPosition = translation
	$OverclockStun.defaultDuration = overclockstunDuration
	$WeaponGroup.connectSignals(self)
	$Viewport/Bars.initHealthBar(0,maxHealth,maxHealth)
	setShieldCharge(0)
	._initialize()

func setShieldCharge(value):
	if value != 0:
		$Viewport/Bars.initShieldBar(value,value)
	$Shield.setCharge(value)
	
func _process(delta):
	MetaData.setSimpleMeta(MetaData.LifeTime,delta)
	
	if Input.is_action_just_pressed("Activateoverclock"):
		emit_signal("useOverclock")
	
	if !canMove || stunned: return

	if Input.is_action_pressed("LeftMouseButton"):
		$WeaponGroup.shoot()

	inputDir = $PlayerInput.processInput()
	
	if inputDir != Vector3(0,0,0):
		if !isMoving:
			emit_signal("startedMoving")
			isMoving = true
	else:
		if isMoving:
			emit_signal("stoppedMoving")
			isMoving = false
	
	$Lowerpart.calcThrust(inputDir,delta)
	processTopRotation()

func _physics_process(delta):
	if !canMove || stunned: return
	processMovement(delta)

func on_newProjectile(projectile):
	projectile.actor = self
	get_parent().add_child(projectile)

func processTopRotation():
	if !$PlayerInput.hasController():
		var intersection = camera.mousePosition(translation)
		if intersection != null :
			$WeaponGroup.look_at(intersection,Vector3(0,1,0))
			$WeaponGroup.rotation.y += PI
			calcDirection()
			$FOV.detection()
	else:
		$WeaponGroup.rotation.y = $PlayerInput.rightStickRotation()

func calcDirection():
	direction =  $WeaponGroup.global_transform.basis.z.normalized()

func processMovement(delta):

	var targetVelocity = inputDir * speed
	velocity = velocity.linear_interpolate(targetVelocity,Acceleraton)
	velocity = move_and_slide(velocity,Vector3(0,1,0))
	translation.y = 0

	MetaData.setSimpleMeta(MetaData.Distance,Vector3(lastPosition - translation).length())
	lastPosition = translation

func _addHealth(value):
	._addHealth(value)
	
	$Viewport/Bars.setHealthBarProgress(currentHealth)

func _addDamage(from,value):
	if $Shield.hasCharge():
		$Shield.decreaseCharge()
		$Viewport/Bars.setShieldProgress($Shield.charge)
		return
	._addDamage(from,value)
	
	var perc = currentHealth / maxHealth
	if perc <= 0.4:
		$PlayerDamagedParticle.play()
	else:
		$PlayerDamagedParticle.stop()
	
	var overlayPercentage =  clamp(1-(currentHealth/maxHealth) ,0.5,1)
	$Overlay.show(0.5,overlayPercentage)
	
	$Viewport/Bars.setHealthBarProgress(currentHealth)
	MetaData.setSimpleMeta(MetaData.DamageTaken,value)

func _onDeath(from):
	._onDeath(from)
	$PlayerDeathAnim.play("PlayerDeath")
	set_process(false)
	set_physics_process(false)
	$WeaponGroup.set_process(false)
	$DeathExplosion.getEnemies()
	

func onPlayerDied(animName):
	emit_signal("playerDied")