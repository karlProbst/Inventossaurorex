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
const INVALID_SLOT = Vector2i(-1, -1)
const EMPTY_SLOT = Vector2i(0, 0)

#checa se os nodes e o array size sao validos
#instancia os nodes vazios do inventario
#carrega itens salvos?
func UpdateGrid(_value):
	itemArray = updateArray(itemArray,Vector2(ARRAY_SIZE_X,ARRAY_SIZE_Y))
	maxItems=ARRAY_SIZE_X*ARRAY_SIZE_Y
	get_node("GridContainer").columns = ARRAY_SIZE_X
	for y in ARRAY_SIZE_Y:
		for x in ARRAY_SIZE_X:
			InstantiateSlotScene(slotScene,get_node("GridContainer"),ItemResource.new(),Vector2i(x,y))
	
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
func InstantiateSlotScene(scene:PackedScene,fatherNode:Node,resource:ItemResource,itemxy:Vector2i):
	if itemxy == INVALID_SLOT:
		printerr("no valid slot,full?")
		return
	var newInstance=scene.instantiate()
	fatherNode.add_child(newInstance)
	resource.itemxy=itemxy
	newInstance.set_item_data(resource)
	
func FindFirstOpenSlot() -> Vector2i:
	for slot in get_node("GridContainer").get_children():
		if slot.item_data != null and slot.item_data.id == 0:
			return slot.item_data.itemxy
	return INVALID_SLOT




func updateArray(array:Array, arraySize:Vector2i)->Array:
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
func AddItem(resource: ItemResource,itemxy:Vector2i=EMPTY_SLOT) -> bool:
	var target_pos: Vector2i
	#Se EMPTY, encontrar o primeiro slot disponível
	if itemxy == EMPTY_SLOT:
		target_pos = FindFirstOpenSlot()
	else:
		target_pos = itemxy
	# Confere se o inventário está cheio
	if target_pos == INVALID_SLOT:
		printerr("Inventário cheio! Não foi possível adicionar o item: ", resource.id)
		return false
	# Confere se está dentro dos limites da grid
	if target_pos.x < 0 or target_pos.x >= ARRAY_SIZE_X or target_pos.y < 0 or target_pos.y >= ARRAY_SIZE_Y:
		printerr("Out of bounds addition!! ", target_pos)
		return false


	for slot in get_node("GridContainer").get_children():
		if slot.item_data.id == 0 and slot.item_data.itemxy == target_pos:
			slot.set_item_data(resource)
			return true

	return false


func _on_mouse_entered_panel() -> void:
	pass 

func _on_mouse_exited_panel() -> void:
	pass 


func _on_add_random_slot_item() -> void:
	AddItem(preload("res://Items/lsd.tres"),Vector2i(randi_range(0,3),randi_range(0,5)))


func _on_add_new_item_pressed() -> void:
	AddItem(preload("res://Items/lsd.tres"))
