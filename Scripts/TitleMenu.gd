extends Control

@onready var animation_player = $AnimationPlayer



func _ready():
	animation_player.play("DisplayLogo")
	await animation_player.animation_finished
	animation_player.play("Load Menu Options")


func _on_new_game_button_pressed():
	animation_player.play("start_game")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://Main.tscn")
