extends Node2D

@onready var item_placement_manager = $ItemPlacementManager


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
