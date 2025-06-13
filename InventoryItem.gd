@tool
extends Control

@export var item_data: ItemResource : set = set_item_data

func set_item_data(value):
	if value:
		item_data = value
	if item_data != null and item_data.icon != null:
		self.texture = item_data.icon

func _process(delta):
	if Engine.is_editor_hint():
		set_item_data(null)
	
