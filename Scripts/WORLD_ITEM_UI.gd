extends Control


@onready var progress_bar = $ProgressBar



var number_image_dic = {
	1: preload("res://Assets/1.png"),
	2: preload("res://Assets/2.png"),
	3: preload("res://Assets/3.png"),
	4: preload("res://Assets/4.png")
	}

var item_resource_holder : Item
var uses_available : int


func _process(delta):
	if Input.is_action_just_pressed("space"):
		fade_out()
	
	if progress_bar.visible:
		progress_bar.value += delta
		if progress_bar.value == progress_bar.max_value:
			progress_bar.visible = false
			reset_pips()
	



func setup(number : int) -> void:
	print("Item Setup Called")
	var item_node = ItemPlacementManager.get_ability(number)
	if item_node == null: return
	
	item_resource_holder = item_node.item_resource 
	progress_bar.max_value = item_resource_holder.cooldown_value
	uses_available = item_resource_holder.max_uses
	%Keyboard_Input.texture = number_image_dic[number]
	%Item_Image.texture = item_node.item_resource.ui_texture
	reset_pips()


func fade_out() -> void:
	var tween = self.create_tween()
	tween.tween_property(get_node(str(uses_available)), "modulate:a", 0.0, 0.3)
	uses_available -= 1
	if uses_available == 0:
		await tween.finished
		ItemPlacementManager.update_object_placement_ability(item_resource_holder.key, false)
		start_progress_bar()


func start_progress_bar() -> void:
	progress_bar.value = 0
	progress_bar.visible = true


func reset_pips() -> void:
	uses_available = item_resource_holder.max_uses
	
	# Cooldown Starts properly but we do not update UI when progress bar is full
	# Check to see if we update the ItemPlacementManager to know if that item can be placed again
	
	ItemPlacementManager.update_object_placement_ability(item_resource_holder.key, true)
	for value in item_resource_holder.max_uses:
		get_node(str(value + 1)).modulate.a = 1.0
		get_node(str(value + 1)).visible = true
	
