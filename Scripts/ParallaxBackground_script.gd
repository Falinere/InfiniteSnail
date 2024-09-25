extends ParallaxBackground

@export var speed = 40

func _process(delta):
	scroll_offset.x -= speed * delta
