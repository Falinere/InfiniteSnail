extends Sprite2D

@export var speed : int = 2


func _physics_process(delta):
	global_position.x -= speed


func _process(delta):
	if global_position.x < -100:
		queue_free()

func setup(new_texture : Texture2D) -> void:
	texture = new_texture
