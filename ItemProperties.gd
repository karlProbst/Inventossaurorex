extends Resource
class_name ItemResource

@export var item_id: int = 0
@export var item_name: String
@export var icon: Texture2D = preload("res://blackTexture.tres")
@export var stackable: bool = false
@export var stack: int
@export var max_stack: int
@export var price: float
