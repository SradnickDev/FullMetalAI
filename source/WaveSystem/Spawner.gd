extends Node

signal waveFullSpawned
signal nextWaveStarts
signal waveDelay(timer)

export(bool) var disabled = false #disabled spawning
export(float) var waveStartDelay = 5	#Time before the Wave Spawner starts

var defaultPattern			#Current used Pattern if not Overridden, can be replaced
var currentPattern			#used Pattern for Spawning
var overridepattern = []	#to override specific Waves
var currentWave = 0
var leftToSpawn = 0

var navigation

export(NodePath) var playerPath
onready var player = get_node(playerPath)
onready var ready = LazyLink.linkIt(self)

onready var scoreCount = preload("res://Score/ScoreCount.res")

func _ready():
	if disabled: return
	getNav()
	setCurrentPattern()
	getOverridePattern()
	setTimers()
	
func getNav():
	for child in get_children():
		if child.is_class("Navigation"):
			navigation = child

func setCurrentPattern():
	defaultPattern = $DefaultPattern
	currentPattern = defaultPattern

func getOverridePattern():
	for n in $PatternParent.get_children():
		overridepattern.append(n)

func setTimers():
	$BetweenSpawnTimer.wait_time = currentPattern.timeBetweenSpawn
	$BetweenSpawnTimer.one_shot = false
	
	$WaveStartDelay.wait_time = waveStartDelay
	$WaveStartDelay.one_shot = true
	$WaveStartDelay.start()
	emit_signal("waveDelay",$WaveStartDelay)

func onZeroEnemy():
	if disabled: return
	if $WaveAccomplished.stream != null:
		$WaveAccomplished.play()
	$Delay.start()

func delay():
	if disabled: return
	$WaveStartDelay.start()
	emit_signal("waveDelay",$WaveStartDelay)

func _process(delta):
	$WaveDisplay/Stats/Enemycount.text = str("Enemies Detected : ",$EnemyCount.enemyCount)
	$WaveDisplay/Stats/Wavecount.text = str("Wave : ",currentWave)


func startNextWave():
	if leftToSpawn == 0:
		if $WaveStart.stream != null:
			$WaveStart.play()
		scoreCount.addClearPoint(currentWave)
		processWave()

func processWave():
	if disabled: return
	emit_signal("nextWaveStarts")
	currentWave += 1
	MetaData.setSimpleMeta(MetaData.Waves,1)
	var newPattern = setOverridePattern()
	
	if newPattern != null :
		currentPattern = newPattern
		$BetweenSpawnTimer.wait_time = newPattern.timeBetweenSpawn
	else :
		currentPattern = defaultPattern
		$BetweenSpawnTimer.wait_time = defaultPattern.timeBetweenSpawn
		
	leftToSpawn = int(currentPattern.defaultAmount + currentWave * currentPattern.increasePerWave)
	
	$BetweenSpawnTimer.start()
	print("Wave : ",currentWave," incomming be prepared for ",leftToSpawn," Enemies.")

#Check all patterns for suitable values
#retrieves temporary pattern or set new default pattern
func setOverridePattern():
	for i in range(overridepattern.size()):
		var newOverridePattern = overridepattern[i]
		if currentWave == newOverridePattern.overrideWave:
			if newOverridePattern.setDefault == true:
				defaultPattern = newOverridePattern
			return newOverridePattern 

func processSpawn():
	if disabled: return
	spawn()
	leftToSpawn -= 1
	
	if leftToSpawn <= 0 : 
		leftToSpawn = 0
		$BetweenSpawnTimer.stop()
		emit_signal("waveFullSpawned")

func spawn():
	if disabled: return
	MetaData.setSimpleMeta(MetaData.Spawned,1)
	
	$Path/PathFollow.unit_offset = rand_range(0.0001,1.0000)
	var spawnPosition = $Path/PathFollow.translation
	var rnd = rand_range(-currentPattern.randomSpawnRange,currentPattern.randomSpawnRange)
	spawnPosition = spawnPosition + Vector3(rnd,0,rnd)
	
	var newEnemy = currentPattern.getEnemy().instance()
	newEnemy.translation = spawnPosition
	$EnemyCount.addEnemy(newEnemy)
	newEnemy.init(player,navigation)

func stop():
	$BetweenSpawnTimer.stop()
	$Delay.stop()
	$WaveStartDelay.stop()
	
	disabled = true
	$WaveDisplay.stop()