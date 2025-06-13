@tool
extends Panel


@onready var slotScene:PackedScene = preload("res://Scenes/Slot.tscn")
 
@export var ARRAY_SIZE_X:int = 3
@export var ARRAY_SIZE_Y:int = 3
var itemsArray:Array=[]

@export var dragNode: Node
var slotNode:Node = dragNode
@export var updateItems: bool

#funcionar com joystick  e touch

#checa se os nodes e o array size sao validos
#instancia os nodes vazios do inventario
#carrega itens salvos?
func _ready() -> void:
	InstantiateScene(slotScene,get_node("GridContainer"))
	InstantiateScene(slotScene,get_node("GridContainer"))
	
	for slot in get_children():
		if slot.has_signal("slot_clicked"):
			slot.connect("slot_clicked", Callable(self, "_on_slot_clicked").bind(slot))

#todo: fazer dicionario
func InstantiateScene(scene:PackedScene,fatherNode:Node):
	var newInstance=scene.instantiate()
	fatherNode.add_child(newInstance)
	var newResource = ItemResource.new()
	newResource.stackable = true
	newResource.stack = randi_range(1,1000)
	newInstance.set("item_data", newResource)
	set_node_item_data(newInstance)
	
func set_node_item_data(node:Node):
	
	if ("item_data" in node):
		if node.item_data.icon != null:
			if node.has_node("Panel/TextureRect"):
				node.get_node("Panel/TextureRect").texture = node.item_data.icon
		if node.item_data.stackable == true and node.item_data.stack>=0:
			if node.has_node("Label"):
				node.get_node("Label").visible = true
				node.get_node("Label").text = str(node.item_data.stack)
		
	
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

#adicionar novo item
func addItem():
	pass

func _on_mouse_entered_panel() -> void:
	pass 

func _on_mouse_exited_panel() -> void:
	pass 
