extends Node2D

@export var item_total : int = 0

@onready var item_container = $UI/Item_Container
@onready var label = %Label
@onready var item = %Item



# Called when the node enters the scene tree for the first time.
func _ready():
	#item_container.connect("update_ui", item_container.update_ui)
	ItemPlacementManager.obstacle_bucket = $ObstacleBucket
	ItemPlacementManager.update_ui.connect(item_container.update_ui)
	item.timeout.connect(ItemPlacementManager.add_new_option)


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




