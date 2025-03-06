extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("controller"):
		Changer.mementocount += 1
		print("memento count: " + str(Changer.mementocount))
		self.queue_free()
