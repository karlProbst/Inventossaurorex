@tool
extends Panel

@export var ARRAY_SIZE_X = 3
@export var ARRAY_SIZE_Y = 3

@export var dragNode: Node
@export var updateItems: bool : set = update_items

#checa se os nodes e o array size sao validos
#instancia os nodes vazios do inventario
#carrega itens salvos?
func _ready() -> void:
	pass

#checa se ta segurando mouse/soltando e a posiçao do cursor
func _input(event):
	pass
	
#trocar items
func SwapItens(nodeA:Node, nodeB:Node) -> void:
	pass
	
func update_items(value):
	updateItems = false
	
	for node in get_node("GridContainer").get_children():
		if node.has_method("set_item_data"):
			node.set_item_data(null)
		else:
			print("é ne, foda")
