extends Control


@export var load_scene : PackedScene
@export var in_time : float = 0.5
@export var fade_in_time : float = 1.5
@export var pause_time : float = 1.5
@export var fade_out_time : float = 1.5
@export var out_time : float = 0.5
@onready var splash_screen = $CenterContainer/TextureRect
@onready var jam = $CenterContainer/Jam


func _ready():
	fade()


func fade() -> void:
	splash_screen.modulate.a = 0.0
	jam.modulate.a = 0.0
	
	#Animate Made with Godot
	var tween = self.create_tween()
	tween.tween_interval(in_time)
	tween.tween_property(splash_screen, "modulate:a", 1.0, fade_in_time)
	tween.tween_interval(pause_time)
	tween.tween_property(splash_screen, "modulate:a", 0.0, fade_out_time)
	tween.tween_interval(out_time)
	await tween.finished
	
	#Animate GameJam Logo
	animate_jam_logo()


func animate_jam_logo() -> void:
	
	var tween = self.create_tween()
	tween.tween_interval(in_time)
	tween.tween_property(jam, "modulate:a", 1.0, fade_in_time)
	tween.tween_interval(pause_time)
	tween.tween_property(jam, "modulate:a", 0.0, fade_out_time)
	tween.tween_interval(out_time)
	await tween.finished
	
	#Change scene to Title scene
	get_tree().change_scene_to_packed(load_scene)
