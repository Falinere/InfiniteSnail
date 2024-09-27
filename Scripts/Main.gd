extends Node2D

signal Main_Scene_Loaded

@export var item_total : int = 0

@onready var item_container = $UI/Item_Container
@onready var label = %Label
@onready var item = %Item
@onready var animation_player = $AnimationPlayer



# Called when the node enters the scene tree for the first time.
func _ready():
	#item_container.connect("update_ui", item_container.update_ui)
	animation_player.play("reveal")
	ItemPlacementManager.obstacle_bucket = $ObstacleBucket
	ItemPlacementManager.update_ui.connect(item_container.update_ui)
	item.timeout.connect(ItemPlacementManager.add_new_option)
	ItemPlacementManager.main_scene_on()
	Main_Scene_Loaded.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
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
