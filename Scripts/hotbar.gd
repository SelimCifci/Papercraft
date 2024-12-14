# edit style

extends Node

var hotbar_slots = 9
var item_scene = preload("res://Scenes/item.tscn")

@export var selected_slot = 0

@onready var player = get_parent()

func _ready():
	light_up(selected_slot)
	
func _process(_delta):
	if Input.is_action_just_pressed("drop"):
		drop()
		
	show_items()
	check_items()

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				light_down(selected_slot)
				
				if selected_slot == hotbar_slots-1:
					selected_slot = 0
				else:
					selected_slot += 1
					
				light_up(selected_slot)
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				light_down(selected_slot)
				
				if selected_slot == 0:
					selected_slot = hotbar_slots-1
				else:
					selected_slot -= 1
					
				light_up(selected_slot)
			
func light_up(slot):
	get_node("Slot" + str(slot)).texture.region = Rect2(16, 0, 16, 16)
	
func light_down(slot):
	get_node("Slot" + str(slot)).texture.region = Rect2(0, 0, 16, 16)
	
func show_items():
	for i in range(hotbar_slots):
		if not player.godmode:
			if Data.items[i][0] >= 0:
				get_node("Slot" + str(i)).get_child(0).texture.region = Rect2(Data.items[i][0]*16, Data.items[i][1]*16, 16, 16)
				get_node("Slot" + str(i)).get_child(1).get_child(0).text = str(Data.items[i][2])
			else:
				get_node("Slot" + str(i)).get_child(0).texture.region = Rect2(112,112,16,16)
				get_node("Slot" + str(i)).get_child(1).get_child(0).text = ""
		else:
			if Data.items[i][0] >= 0:
				get_node("Slot" + str(i)).get_child(0).texture.region = Rect2(Data.godmode_items[i][0]*16, Data.godmode_items[i][1]*16, 16, 16)
				get_node("Slot" + str(i)).get_child(1).get_child(0).text = str(Data.godmode_items[i][2])
			else:
				get_node("Slot" + str(i)).get_child(0).texture.region = Rect2(112,112,16,16)
				get_node("Slot" + str(i)).get_child(1).get_child(0).text = ""
			
func check_items():
	for i in range(hotbar_slots):
		if Data.items[i][2] <= 0:
			Data.items[i][2] = 0
			Data.items[i][0] = -1
			Data.items[i][1] = -1
			
func drop():
	if Data.items[selected_slot][2] > 0:
		Data.items[selected_slot][2] -= 1
		
		var world = get_parent().get_parent()
		var item_node = item_scene.instantiate()
		
		item_node.get_child(0).play("item_anim")
		item_node.texture.region = Rect2(Data.items[selected_slot][0]*16,Data.items[selected_slot][1]*16,16,16)
		item_node.position = get_parent().position
		world.add_child(item_node)
		if Data.items[selected_slot][2] == 0:
			Data.items[selected_slot][0] = -1
			Data.items[selected_slot][1] = -1
		
	
