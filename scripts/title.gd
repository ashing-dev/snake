extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		$CTA.visible = false
		$StartSound.play()
		await get_tree().create_timer(1.2).timeout
		get_tree().change_scene_to_file("res://scenes/game_container.tscn")
