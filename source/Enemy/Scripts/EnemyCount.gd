extends Spatial

signal ZeroEnemy

var enemyCount = 0

onready var scoreCount = preload("res://Score/ScoreCount.res")

func addEnemy(enemy):
	enemyCount += 1
	add_child(enemy)
	enemy.connect("death",self,"onEnenmyDeath")

func onEnenmyDeath():
	scoreCount.addKill()
	enemyCount -= 1
	if enemyCount <= 0:
		enemyCount = 0
		emit_signal("ZeroEnemy")

func getEnemyCount():
	return enemyCount