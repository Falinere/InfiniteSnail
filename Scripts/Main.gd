extends Node2D

@export var item_total : int = 0

@onready var item_placement_manager = $ItemPlacementManager
@onready var item_container = $UI/Item_Container



# Called when the node enters the scene tree for the first time.
func _ready():
	#item_container.connect("update_ui", item_container.update_ui)
	item_placement_manager.update_ui.connect(item_container.update_ui)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("one"):
		item_placement_manager.select_item(1)
	
	if Input.is_action_just_pressed("two"):
		item_placement_manager.select_item(2)
	
	if Input.is_action_just_pressed("three"):
		item_placement_manager.select_item(3)
	
	if Input.is_action_just_pressed("four"):
		item_placement_manager.select_item(4)
	
	# Remove this code later
	if Input.is_action_just_pressed("space"):
		add_new_item()



