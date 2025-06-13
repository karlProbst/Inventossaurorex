@tool
extends Panel


@onready var slotScene:PackedScene = preload("res://Scenes/Slot.tscn")
 
@export var ARRAY_SIZE_X:int = 3
@export var ARRAY_SIZE_Y:int = 3
var itemArray:Array=[]

@export var dragNode: Node
var slotNode:Node = dragNode
@export var updateItems: bool :set = UpdateGrid
var maxItems=ARRAY_SIZE_X*ARRAY_SIZE_Y
#funcionar com joystick  e touch

#checa se os nodes e o array size sao validos
#instancia os nodes vazios do inventario
#carrega itens salvos?
func UpdateGrid(value):
	itemArray = updateArray(itemArray,Vector2(ARRAY_SIZE_X,ARRAY_SIZE_Y))
	maxItems=ARRAY_SIZE_X*ARRAY_SIZE_Y
	get_node("GridContainer").columns = ARRAY_SIZE_X
	for x in ARRAY_SIZE_X:
		for y in ARRAY_SIZE_Y:
			InstantiateSlotScene(slotScene,get_node("GridContainer"),ItemResource.new(),Vector2i(y,x))
	
	for slot in get_children():
		if slot.has_signal("slot_clicked"):
			slot.connect("slot_clicked", Callable(self, "_on_slot_clicked").bind(slot))
func _ready() -> void:
	UpdateGrid(true)

#todo: fazer dicionario
func GetSlotNode(itemxy:Vector2i)->Node:
	for slot in get_node("GridContainer").get_children():
		if "item_data" in slot: 
			if slot.item_data.itemxy==itemxy:
				return slot
	printerr("DIDNT FOUND SLOT NODE")
	return null
func InstantiateSlotScene(scene:PackedScene,fatherNode:Node,resource:ItemResource,itemxy:Vector2i=Vector2i(-1,-1)):
	if itemxy.x==-1:
		itemxy=FindFirstOpenSlot()
		#FULL
		if itemxy.x==-1:
			printerr("FULL, thing is null")
		#CHANGE ITEM
		var slotNode = GetSlotNode(itemxy)
		if not slotNode==null:
			slotNode.item_data=resource
			if "item_data" in slotNode: 
				slotNode.item_data.itemxy=itemxy
				set_node_item_data(slotNode)
	#INSTANTIATE NEW SLOTS
	else:
		var newInstance=scene.instantiate()
		newInstance.set("item_data", resource)
		fatherNode.add_child(newInstance)
		if "item_data" in newInstance: 
			newInstance.item_data.itemxy=itemxy
			set_node_item_data(newInstance)
		
func set_node_item_data(node:Node)->bool:
	
	if ("item_data" in node):
		if node.item_data.icon != null:
			if node.has_node("Panel/TextureRect"):
				node.get_node("Panel/TextureRect").texture = node.item_data.icon
		if node.item_data.stackable == true and node.item_data.stack>=0:
			if node.has_node("Label"):
				node.get_node("Label").visible = true
				node.get_node("Label").text = str(node.item_data.stack)
		if node.item_data.id==0:
			node.get_node("Label").visible = true		
			node.get_node("Label").text = str(node.item_data.itemxy)
		return true
	else:
		printerr("couldn't instantiate slot node")
		return false
func FindFirstOpenSlot()->Vector2i:
	#empty
	if get_node("GridContainer").get_child_count()==0:
		return Vector2i(0,0)
	for slot in get_node("GridContainer").get_children():
		if "item_data" in slot: 
			if slot.item_data.id==0:
				return slot.item_data.itemxy
	#FULL
	return Vector2i(-1,-1)
			
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
func SwapItensProperties(nodeRemove:Node, nodeAdd:Node) -> void:
	if not "item_data" in nodeRemove:
		printerr("nodeA has invalid properties")
		return
	if not "item_data" in nodeAdd:
		printerr("nodeB has invalid properties")
		return
	var propertiesTemp=nodeAdd.item_data
	nodeAdd.item_data=nodeRemove.item_data
	nodeRemove.item_data=propertiesTemp

#adicionar novo item
func addItem():
	pass

func _on_mouse_entered_panel() -> void:
	pass 

func _on_mouse_exited_panel() -> void:
	pass 


func _on_add_lsd_button_pressed() -> void:
	InstantiateSlotScene(slotScene,get_node("GridContainer"),preload("res://Items/lsd.tres"))
