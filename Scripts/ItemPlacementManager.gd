extends Node

signal update_ui

const WORLD_ITEM = preload("res://Scenes/Items/WorldItem.tscn")
const ITEM_NODE = preload("res://Scenes/ItemNode.tscn")


var resource_array : Array[Item] = []
var item_total : int = 0
var obstacle_bucket


func _ready():
	popuplate_resource_array()
	resource_array.shuffle()
	await get_tree().create_timer(2.0).timeout
	add_new_option()




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
	
	for item_node in obstacle_bucket.get_children():
		if item_node.preview_enabled:
			item_node.queue_free()
	
	var item_instance = WORLD_ITEM.instantiate()
	item_instance.position = get_window().get_mouse_position()
	item_instance.item_resource = item.item_resource
	item_instance.preview_enabled = true
	obstacle_bucket.add_child(item_instance)


func add_new_option() -> void:
	if item_total > 4: return
	var option = ITEM_NODE.instantiate()
	option.item_resource = resource_array[item_total]
	option.name = option.item_resource.name
	item_total += 1
	option.item_resource.key = item_total
	add_child(option)
	update_ui.emit()


func get_active_abilities() -> Array:
	return get_children()


func get_ability(number : int) -> Node:
	if number > get_child_count():
		return null
	return get_child(number - 1)
