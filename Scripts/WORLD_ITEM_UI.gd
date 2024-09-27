extends Control

var number_image_dic = {
	1: preload("res://Assets/1.png"),
	2: preload("res://Assets/2.png"),
	3: preload("res://Assets/3.png"),
	4: preload("res://Assets/4.png")
	}


func setup(number : int) -> void:
	print("Item Setup Called")
	var item_node = ItemPlacementManager.get_ability(number)
	if item_node == null: return
	%Keyboard_Input.texture = number_image_dic[number]
	%Item_Image.texture = item_node.item_resource.ui_texture
