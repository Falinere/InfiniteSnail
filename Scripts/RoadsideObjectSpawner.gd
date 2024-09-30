extends Marker2D


@onready var timer = $Timer


const ROADSIDE_ITEM = preload("res://Scenes/RoadsideObject.tscn")

var enviroment_images : Array = [
	preload("res://Assets/Environments/Desert/humanskull.png"),
	preload("res://Assets/Environments/Desert/cowskull.png")
]


func _ready():
	timer.timeout.connect(spawn_enviroment_item)
	setup_timer()


func setup_timer() -> void:
	var random_number = randi() % 15 + 10
	timer.start(random_number)


func spawn_enviroment_item() -> void:
	var image = enviroment_images.pick_random()
	var environment_item = ROADSIDE_ITEM.instantiate()
	environment_item.setup(image)
	add_child(environment_item)
	setup_timer()
