extends KinematicBody
#Base Class for Enemies and Player

signal death
signal startedMoving
signal stoppedMoving

var customForce = preload("res://Player/Scripts/CustomForce.gd").new()

export(float)var maxHealth = 100
export(float)var speed = 20

var currentHealth = 100
var velocity = Vector3()
var direction = Vector3()
var isAlive = true
var canMove = true
var stunned = false

func _ready():
	customForce.connect("forceStopped",self,"onForceStopped")
	_initialize()

func _initialize():
	currentHealth = maxHealth

#decrease current Health with passed damage value
func _addDamage(from,value):
	currentHealth = clamp(currentHealth - value,0,maxHealth)
	if currentHealth <= 0:
		_onDeath(from)
		
#increase health by value
func _addHealth(value):
	currentHealth = clamp(currentHealth + value,0,maxHealth)

func _onDeath(from):
	if isAlive:
		emit_signal("death")
	isAlive = false

func adjustSpeed(value):
	speed += value

func _physics_process(delta):
	stunned = customForce.enabled
	if stunned:
		velocity = customForce.getForce(delta)

func onForceStopped():
	velocity = Vector3(0,0,0)
	move_and_slide(Vector3(0,0,0))

#Add Force with a duration in a direction
func addForce(dir,force,duration):
	velocity = Vector3(0,0,0)
	
	customForce.setForce(dir,force,duration)