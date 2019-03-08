extends Control

func setStats():
	$LifeTime/Label.text = getLifeTime()
	$Killed/Label.text = getKillCount()
	$Accuracy/Label.text = getAccuracy()
	$WeaponStats/Label.text = getMGTime();
	$WeaponStats/Label2.text = getRLTime()
	$WeaponStats/Label3.text = getEMPTime()

func getLifeTime():
	return str(MetaData.getSimpleMeta(MetaData.LifeTime))

func getSpawnedCount():
	return int(MetaData.getSimpleMeta(MetaData.Spawned))

func getKillCount():
	var killed = int(MetaData.getSimpleMeta(MetaData.Killed))
	var count = getSpawnedCount()
	return str(clamp(killed,0,count))

func getAccuracy():
	var acc = int(MetaData.getSimpleMeta(MetaData.Accuracy))
	acc = clamp(acc,0,100)
	return str(acc,"%")

func getMGTime():
	return str("MG : ",MetaData.getWeaponMeta(MetaData.MachineGun,MetaData.Selection))

func getRLTime():
	return str("RL : ",MetaData.getWeaponMeta(MetaData.RocketLauncher,MetaData.Selection))

func getEMPTime():
	return str("EMP : ",MetaData.getWeaponMeta(MetaData.EMPGun,MetaData.Selection))