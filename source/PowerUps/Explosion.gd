extends Node

func explode(enemies,from,damage):
	for enemy in enemies:
		if enemy.get_ref():
			enemy.get_ref()._addDamage(from,damage)