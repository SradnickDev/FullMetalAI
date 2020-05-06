extends Node


enum weaponMeta { MachineGun,RocketLauncher,EMPGun }
enum metaType { Waves,Spawned,Killed,LifeTime,Distance,Hitted,Missed,DamageTaken,Accuracy,Damage,Fired,Selection,Score,Map,Mode}

var metaLibrary = {}

func _ready():
	randomize()
	init()

func init():
	metaLibrary = {}
	for type in metaType:
		metaLibrary[str(metaType[type])] = 0
		if metaType[type] == metaType.Mode:
			metaLibrary[str(metaType[type])] = "Regular"

func addSimpleMeta(type):
	var key = str(type)
	if metaLibrary.has(key): return
	metaLibrary[key] = 0

func addWeaponMeta(weapon,type):
	var key = str(weapon,type)
	if metaLibrary.has(key): return
	metaLibrary[key] = 0

func setSimpleMeta(type,value):
	var key = str(type)
	if metaLibrary.has(key):
		metaLibrary[key] = float(metaLibrary[key]) + value

func setSimpleMetaOnly(type,value):
	var key = str(type)
	if metaLibrary.has(key):
		metaLibrary[key] = value

func setWeaponMeta(weapon,type,value):
	var key = str(weapon,type)
	if metaLibrary.has(key):
		metaLibrary[key] = float(metaLibrary[key]) + value

func getSimpleMeta(type):
	var key = str(type)
	if metaLibrary.has(key):
		return metaLibrary[key]

func getWeaponMeta(weapon,type):
	var key = str(weapon,type)
	if metaLibrary.has(key):
		return metaLibrary[key]

func calculateMeta():
	calclifeTime()
	calcAccuracy()
	calcSelection()

func calclifeTime():
	var total = int(metaLibrary[str(MetaData.LifeTime)])
	var time = convertTime(total)
	metaLibrary[str(MetaData.LifeTime)] = time

func calcAccuracy():
	var hits = metaLibrary[str(MetaData.Hitted)]
	var fired = metaLibrary[str(MetaData.Fired)]
	if hits == 0 || fired == 0: return
	var accu = float(hits) / float(fired)
	accu *= 100
	accu = stepify(accu,0.01)
	metaLibrary[str(MetaData.Accuracy)] = accu
	
func calcSelection():
	for weapon in weaponMeta:
		var totalTime = metaLibrary[str(weaponMeta[weapon],MetaData.Selection)]
		var correctTime = convertTime(totalTime)
		metaLibrary[str(weaponMeta[weapon],MetaData.Selection)] = correctTime
	
	
func convertTime(seconds):
	var total = int(seconds)
	var secs = total % 60
	var minutes = total / 60
	if secs <= 9:
		secs = str("0",secs)
	return str(minutes,":",secs)

func reset():
	for type in metaType:
		if metaType[type] == metaType.Map:
			continue
		if metaType[type] == metaType.Mode:
			continue
		metaLibrary[str(metaType[type])] = 0
