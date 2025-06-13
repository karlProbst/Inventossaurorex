@tool
extends Panel

@export var ARRAY_SIZE_X:int = 3
@export var ARRAY_SIZE_Y:int = 3
var itemsArray:Array=[]

@export var dragNode: Node
var slotNode:Node = dragNode
@export var updateItems: bool : set = update_items

#checa se os nodes e o array size sao validos
#instancia os nodes vazios do inventario
#carrega itens salvos?
func _ready() -> void:
	for slot in get_children():
		if slot.has_signal("slot_clicked"):
			slot.connect("slot_clicked", Callable(self, "_on_slot_clicked").bind(slot))

func updateArray(array:Array, arraySize:Vector2)->Array:
	if not (arraySize.x>0 and arraySize.y>0):
		printerr("array size null or <=0")
		return array
	array.resize(arraySize.x)
	for x in arraySize.x:
		array[x] = []
		array[x].resize(arraySize.y)	
	return array
	
#checa se ta segurando mouse/soltando e a posiçao do cursor
func _input(event):
	pass
	
#trocar items
func SwapItensProperties(nodeA:Node, nodeB:Node) -> void:
	if not "item_data" in nodeA:
		printerr("nodeA has invalid properties")
		return
	if not "item_data" in nodeB:
		printerr("nodeB has invalid properties")
		return
	var propertiesTemp=nodeB.item_data
	nodeB.item_data=nodeA.item_data
	nodeA.item_data=propertiesTemp
	
	
func update_items(value):
	updateItems = false
	
	for node in get_node("GridContainer").get_children():
		if node.has_method("set_item_data"):
			node.set_item_data(null)
		else:
			print("é ne, foda")




func _on_mouse_entered_panel() -> void:
	pass 


func _on_mouse_exited_panel() -> void:
	pass 
