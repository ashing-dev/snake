extends Node2D


func _unhandled_input(event: InputEvent):
	if event is InputEventKey || event is InputEventJoypadButton:
		$CTA.visible = false
		$StartSound.play()
		await get_tree().create_timer(1.2).timeout
		get_tree().change_scene_to_file("res://scenes/game_container.tscn")
		
