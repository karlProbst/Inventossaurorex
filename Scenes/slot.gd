extends Control

@onready var item_data: ItemResource = null
@onready var icon_node = get_node_or_null("Panel/TextureRect")
@onready var label_node = get_node_or_null("Label")

func set_item_data(data: ItemResource) -> void:
	item_data = data
	_update_visual()

func clear_item() -> void:
	item_data = null
	_update_visual()

func _update_visual()->void:
	if item_data==null:
		printerr("item_data is null")
		return 
	# Atualiza o ícone
	if icon_node:
		icon_node.texture = item_data.icon if item_data.icon != null else null
	# Atualiza o stack label
	if label_node:
		if item_data.stackable and item_data.stack >= 0:
			label_node.visible = true
			label_node.text = str(item_data.stack)
		elif item_data.id == 0:
			label_node.visible = true
			label_node.text = str(item_data.itemxy)
		else:
			label_node.visible = false
