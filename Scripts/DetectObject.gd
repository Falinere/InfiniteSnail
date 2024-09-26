extends RayCast2D

signal object_collision(direction)

@export var direction : int = 0


func _physics_process(_delta):
	if is_colliding():
		object_collision.emit(direction)
