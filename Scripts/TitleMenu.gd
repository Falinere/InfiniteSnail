extends Control

@onready var animation_player = $AnimationPlayer
@onready var button_sounds = $ButtonSounds



func _ready():
	animation_player.play("DisplayLogo")
	await animation_player.animation_finished
	animation_player.play("Load Menu Options")


func _on_new_game_button_pressed():
	button_sounds.play()
	animation_player.play("start_game")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://Main.tscn")


func _on_quit_pressed():
	get_tree().quit()
