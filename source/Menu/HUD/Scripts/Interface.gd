extends Control

func initHealthBar(minHealth,maxHealth,currentHealth):
	$HealthBar.initBar(minHealth,maxHealth,currentHealth)

func initShieldBar(maxCount,current):
	$ShieldBar.initBar(0,maxCount,current)
	
	$HealthBar.visible = false
	$ShieldBar.visible = true

func setShieldProgress(current):
	$ShieldBar.setProgress(current)
	
	if current == $ShieldBar.min_value:
		$HealthBar.visible = true
		$ShieldBar.visible = false
	
func setProgress(current):
	$HealthBar.setProgress(current)

func setHealthBarProgress(currentHealth):
	$HealthBar.setProgress(currentHealth)

func onWeaponChanged(currentAmount,maxAmount):
	$OverlcockBar.initBar(0,maxAmount,currentAmount)

func onOverclockAmountChange(currentValue):
	$OverlcockBar.modulate = Color(1,1,1,1)
	$OverlcockBar.setProgress(currentValue)