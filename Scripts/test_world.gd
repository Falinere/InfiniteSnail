extends Node2D

const WORLD_ITEM = preload("res://Scenes/Items/WorldItem.tscn")

var resource_array : Array[Item] = []

# Called when the node enters the scene tree for the first time.
func _ready():
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



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var item_instance = WORLD_ITEM.instantiate()
		item_instance.position = get_global_mouse_position()
		item_instance.item_resource = resource_array[0]
		add_child(item_instance)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var item_instance = WORLD_ITEM.instantiate()
		item_instance.position = get_global_mouse_position()
		item_instance.item_resource = resource_array[1]
		add_child(item_instance)


