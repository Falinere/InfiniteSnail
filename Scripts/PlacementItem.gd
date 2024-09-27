extends Node2D
class_name PlacementItem

@export var item_resource : Item
@export var speed : int = 2
@onready var sprite_2d = $Sprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var collision_polygon_2d = $Area2D/CollisionPolygon2D
@onready var area_2d = $Area2D


var preview_enabled : bool = false
var animation_playing : bool = false


func _ready():
	
	animated_sprite_2d.animation_finished.connect(disable_preview)
	# makes each material shader unique so they behave independantly
	sprite_2d.material = sprite_2d.material.duplicate(true)
	
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
	
	if preview_enabled and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and ItemPlacementManager.can_place_object:
		setup()
	
	sprite_2d.material.set_shader_parameter("PLACEABLE", ItemPlacementManager.can_place_object)



func _physics_process(delta):
	
	if !preview_enabled:
		global_position.x -= speed
		return
	
	global_position = get_global_mouse_position()



func setup() -> void:
	
	# Tells the Item Manager that we've used an Item so it can update the UI
	ItemPlacementManager.reduce_item_quantity(item_resource.key)
	
	sprite_2d.material.set_shader_parameter("PREVIEW", false)
	area_2d.monitorable = true
	area_2d.monitoring = true
	match item_resource.name:
		"CartoonBomb":
			preview_enabled = false
		"SaltPile":
			animated_sprite_2d.offset = item_resource.offset
			animated_sprite_2d.play("salt")
			preview_enabled = false
		"SpikeTrap":
			animated_sprite_2d.play("spiketrap")
			preview_enabled = false
		"SpinningBlade":
			sprite_2d.visible = false
			animated_sprite_2d.offset = item_resource.offset
			animated_sprite_2d.flip_h = true
			preview_enabled = false
			animated_sprite_2d.play("sawblade-1")
			await animated_sprite_2d.animation_finished
			animated_sprite_2d.play("sawblade-2")
		_:
			preview_enabled = false


func disable_preview() -> void:
	preview_enabled = false


func _on_screen_exited():
	queue_free()
