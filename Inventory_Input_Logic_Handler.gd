extends Node

@export var inventory_node : Node

#mouse
#keyboard
#controller

#select
#drag
#drop
#highlight
#Hint
#use
var selected_slot: Vector2i = Vector2i.ZERO
var dragging_item = null

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_inventory_open"):
		toggle_inventory_visibility()
	elif event.is_action_pressed("ui_inventory_use_item"):
		use_selected_item()
	elif event.is_action_pressed("ui_inventory_drop_item"):
		drop_selected_item()
	# Adicione outras ações conforme necessário

func toggle_inventory_visibility() -> void:
	inventory_node.visible = not inventory_node.visible

func use_selected_item() -> void:
	# Exemplo básico
	pass

func drop_selected_item() -> void:
	# Exemplo básico
	pass
	
func _on_slot_hover_entered(slot):
	slot.get_node("Highlight").visible=true

func _on_slot_hover_exited(slot):
	slot.get_node("Highlight").visible=false





func _on_slot_mouse_entered() -> void:
	print("Mouse left: ")
