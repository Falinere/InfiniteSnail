extends Node2D
class_name PlacementItem

@export var item_resource : Item
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var collision_polygon_2d = $Area2D/CollisionPolygon2D

var preview_enabled : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = item_resource.texture
	name = item_resource.name
	if item_resource.shape_2d:
		collision_shape_2d.shape = item_resource.shape_2d
		collision_polygon_2d.disabled = true
	else:
		collision_polygon_2d.polygon = item_resource.polygon_2d
		collision_shape_2d.disabled = true




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if preview_enabled and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		preview_enabled = false



func _physics_process(delta):
	if preview_enabled:
		global_position = get_global_mouse_position()
	else:
		global_position.x -= 3


func setup() -> void:
	
	pass


func _on_screen_exited():
	queue_free()
