extends Area2D

#Ocean


func _on_body_entered(body):
	if body.is_in_group("Swimmer"):
		if body.swimming == false:
			body.swimming = true


func _on_body_exited(body):
	if body.is_in_group("Swimmer"):
		if body.swimming == true:
			body.swimming = false
