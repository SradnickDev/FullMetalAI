extends Area

func getEnemies():
	var enemies = get_overlapping_bodies()
	for enemy in enemies:
		destroy(enemy)

func destroy(enemy):
	if enemy.has_method("nukeKill"):
		enemy.nukeKill()