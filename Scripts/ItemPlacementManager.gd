extends Node

signal update_ui

const WORLD_ITEM = preload("res://Scenes/Items/WorldItem.tscn")
const ITEM_NODE = preload("res://Scenes/ItemNode.tscn")


var resource_array : Array[Item] = []



func _ready():
	popuplate_resource_array()
	resource_array.shuffle()
	add_new_option(0)



func popuplate_resource_array():
	var dir = DirAccess.open("res://Resources/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):
				var item = load("res://Resources/".path_join(file_name))
				resource_array.append(item)
			file_name = dir.get_next()
		dir.list_dir_end()


func select_item(key_pressed : int) -> void:
	
	var selected_item = does_slot_exist(key_pressed)
	
	if selected_item == null:
		return
	
	preview_item(selected_item)


func does_slot_exist(key_pressed : int) -> Node2D:
	 
	for child in get_children():
		if child.item_resource.key == key_pressed:
			return child
	
	return null



func preview_item(item : Node) -> void:
	
	update_ui.emit()
	
	var item_instance = WORLD_ITEM.instantiate()
	item_instance.position = get_parent().get_global_mouse_position()
	item_instance.item_resource = item.item_resource
	item_instance.preview_enabled = true
	get_parent().get_node("ObstacleBucket").add_child(item_instance)


func add_new_option(number : int) -> void:
	var option = ITEM_NODE.instantiate()
	option.item_resource = resource_array[number]
	option.item_resource.key = number + 1
	add_child(option)
