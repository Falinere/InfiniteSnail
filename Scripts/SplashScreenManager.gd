extends Control


@export var load_scene : PackedScene
@export var in_time : float = 0.5
@export var fade_in_time : float = 1.5
@export var pause_time : float = 1.5
@export var fade_out_time : float = 1.5
@export var out_time : float = 0.5
@onready var splash_screen = $CenterContainer/TextureRect
@onready var animated_sprite_2d = $CenterContainer/AnimatedSprite2D


func _ready():
	fade()


func fade() -> void:
	splash_screen.modulate.a = 0.0
	
	#Animate Made with Godot
	var tween = self.create_tween()
	tween.tween_interval(in_time)
	tween.tween_property(splash_screen, "modulate:a", 1.0, fade_in_time)
	tween.tween_interval(pause_time)
	tween.tween_property(splash_screen, "modulate:a", 0.0, fade_out_time)
	tween.tween_interval(out_time)
	await tween.finished
	
	#Animate Immortal Snail Logo
	#animate_game_logo()
	
	#Change scene to Title scene
	get_tree().change_scene_to_packed(load_scene)


func animate_game_logo() -> void:
	animated_sprite_2d.visible = true
	animated_sprite_2d.play("default")
	await animated_sprite_2d.animation_finished
	var tween2 = self.create_tween()
	tween2.tween_interval(pause_time)
	tween2.tween_property(animated_sprite_2d, "modulate:a", 0.0, fade_out_time)
	tween2.tween_interval(out_time)
	await tween2.finished
