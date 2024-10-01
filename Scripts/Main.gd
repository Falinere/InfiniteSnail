extends Node2D

signal Main_Scene_Loaded

@export var item_total : int = 0

@onready var item_container = $UI/Item_Container
@onready var label = %Label
@onready var animation_player = $AnimationPlayer
@onready var game_timer = $Game_Timer
@onready var snail = $Snail
@onready var truck = $Truck
@onready var soundtrack = $Soundtrack

var game_over : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	#item_container.connect("update_ui", item_container.update_ui)
	animation_player.play("reveal")
	ItemPlacementManager.obstacle_bucket = $ObstacleBucket
	ItemPlacementManager.update_ui.connect(item_container.update_ui)
	ItemPlacementManager.reduce_item.connect(item_container.item_used)
	ItemPlacementManager.main_scene_on()
	snail.lose_game.connect(game_lose)
	Main_Scene_Loaded.emit()
	game_timer.timeout.connect(game_win)
	soundtrack.play(26.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if game_over:
		return
	
	if Input.is_action_just_pressed("one"):
		ItemPlacementManager.select_item(1)
	
	if Input.is_action_just_pressed("two"):
		ItemPlacementManager.select_item(2)
	
	if Input.is_action_just_pressed("three"):
		ItemPlacementManager.select_item(3)
	
	if Input.is_action_just_pressed("four"):
		ItemPlacementManager.select_item(4)



func _on_mouse_entered_object_area():
	ItemPlacementManager.can_place_object = true


func _on_mouse_exited_object_area():
	ItemPlacementManager.can_place_object = false


func game_win() -> void:
	game_over = true
	snail.turn_off_collision()
	animation_player.play("game_win")
	ItemPlacementManager.game_reset()


func game_lose() -> void:
	if game_over:
		return
	
	animation_player.play("game_lose")
	game_timer.stop()
	ItemPlacementManager.game_reset()


func _on_play_again_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")


func _on_title_screen_pressed():
	get_tree().change_scene_to_file("res://Scenes/TitleMenu.tscn")
