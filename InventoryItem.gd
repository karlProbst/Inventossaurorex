@tool
extends Control

@export var item_data: ItemResource : set = set_item_data
signal mouse_entered_slot
signal mouse_exited_slot

func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func set_item_data(value):
	if value:
		item_data = value
	if item_data != null:
		if item_data.icon != null:
			if has_node("Panel/TextureRect"):
				get_node("Panel/TextureRect").texture = item_data.icon
		if item_data.stackable == true and item_data.stack>=0:
			if has_node("Label"):
				get_node("Label").visible = true
				get_node("Label").text = str(item_data.stack)
		
#todo: remove process
func _process(delta):
	if Engine.is_editor_hint():
		set_item_data(null)
	


func _on_mouse_entered() -> void:
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	pass # Replace with function body.
