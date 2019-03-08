extends HBoxContainer

func setRank(value):
	$Rank.text = str(value)

func setName(name):
	$Name.text = str(name)

func setMap(map):
	$Map.text = str(map)
	
func setMod(mod):
	$Mod.text = str(mod)

func setTime(time):
	$Time.text = str(time)

func setKillCount(number):
	$KillCount.text = str(number)

func setScore(value):
	$Score.text = str(value)