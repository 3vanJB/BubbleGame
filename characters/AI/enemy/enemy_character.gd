class_name EnemyCharacter extends BattleMember


func _on_battle_trigger_area_body_entered(body: Node2D) -> void:
	if not body is PlayerCharacter:
		return
	trigger_battle_with_player()

func trigger_battle_with_player() -> void:
	var enemies_in_battle : Array[EnemyCharacter] = []
	enemies_in_battle.append(self)
	for body in $EnemiesInArea.get_overlapping_bodies():
		if body == self:
			continue
		var enemy : EnemyCharacter = body as EnemyCharacter
		if enemy == null:
			continue
		enemies_in_battle.append(enemy)
	Auto.transition_to_battle(enemies_in_battle, self)
