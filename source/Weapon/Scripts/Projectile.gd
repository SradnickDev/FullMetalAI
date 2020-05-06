extends KinematicBody

const ObstacleLayer = 8
const EnemyLayer = 2

signal colliding(target)

export(float) var lifeTime = 2
export(float) var speed = 150
var currentLifeTime = 0

var isActive = false
var moveDirection = Vector3()
var actor = null
var canMove = true
var collision

func _ready():
	LazyLink.linkIt(self)
	MetaData.setSimpleMeta(MetaData.Fired,1)
	$LifeTime.connect("timeout",self,"onLifeTimeIsOver")
	$LifeTime.wait_time = lifeTime
	$LifeTime.start()

func _process(delta):
	if canMove:
		collision = move_and_collide(moveDirection * delta * speed)
		if collision != null:
			_onCollision(collision)
			collision = null

func _onCollision(collision):
	_onEnemyCollision(collision)
	_onObstacleCollision(collision)

func _onEnemyCollision(collision):
	if collision.collider.collision_layer == EnemyLayer:
		emit_signal("colliding",collision.collider)
		_onContact(collision.collider)

func _onObstacleCollision(collision):
	if collision.collider.collision_layer == ObstacleLayer:
		emit_signal("colliding",collision.collider)
		_onContact(collision.collider)

func _onContact(target):
	pass

func onLifeTimeIsOver():
	freeProjectile(false)
		
func freeProjectile(hit):
	if hit:
		MetaData.setSimpleMeta(MetaData.Hitted,1)
	else:
		MetaData.setSimpleMeta(MetaData.Missed,1)
	queue_free()
	