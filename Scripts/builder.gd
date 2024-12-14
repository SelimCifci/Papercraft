extends Node

@onready var tilemap: TileMap = get_parent()
@onready var raycast: RayCast2D = get_parent().get_parent().get_node("Player/RayCast2D")
@onready var break_anim: AnimatedSprite2D = get_parent().get_parent().get_node("Overlay/AnimatedSprite2D")
@onready var body_check: Area2D = get_parent().get_parent().get_node("Area2D")
@onready var player: CharacterBody2D = get_parent().get_parent().get_node("Player")

var selected_tile
var body_in
var raycast_normal
var raycast_pos
var tile_pos

func _ready():
	break_anim.play("Break", 1)

func _process(_delta):
	print(Data.items)
	
	raycast_normal = raycast.get_collision_normal()
	raycast_pos = raycast.get_collision_point()
	tile_pos = tilemap.local_to_map(raycast_pos-raycast_normal*8)
	
	body_check.transform.origin = tilemap.map_to_local(Vector2(tile_pos)+raycast_normal)
	
	mine()
	place()

func mine():
	if Input.is_action_pressed("mine") and break_anim.frame == 0 and tilemap.get_cell_source_id(0,tile_pos) != -1 and raycast.is_colliding():
		if tilemap.get_cell_atlas_coords(0,tile_pos) != Data.coords["bedrock"] or player.godmode:
			selected_tile = tile_pos
			
			break_anim.frame = 1
			break_anim.speed_scale = 1/tilemap.get_cell_tile_data(0,tile_pos).get_custom_data("time")
			
	if selected_tile == tile_pos and (break_anim.frame == 11 or player.godmode):
		break_anim.frame = 0
		break_anim.speed_scale = 0
		
		if not player.godmode: give_item(tile_pos)
		tilemap.set_cell(0, tile_pos)
	elif selected_tile != tile_pos:
		break_anim.frame = 0
		break_anim.speed_scale = 0

func place():
	if Input.is_action_just_pressed("place") and not body_in and raycast.is_colliding():
		var selected_index = get_parent().get_parent().get_node("Player/Hotbar").selected_slot
		var selected_pos = Vector2i(Data.items[selected_index][0],Data.items[selected_index][1])
		
		tilemap.set_cell(0,Vector2(tile_pos)+raycast_normal,0,selected_pos)
		if not player.godmode: Data.items[selected_index][2] -= 1

func give_item(tile_pos):
	if tilemap.get_cell_source_id(0, tile_pos) != -1:
		if tilemap.get_cell_tile_data(0, tile_pos).get_custom_data("hand"):
			var items = Data.items
			tile_pos = Data.coords[tilemap.get_cell_tile_data(0, tile_pos).get_custom_data("dropped_block")]
			# ---------------------------------------------------------------------------------
			for i in range(len(items)):
				var item_pos = Vector2i(items[i][0], items[i][1])
				
				if item_pos == tile_pos and items[i][2] < 64:
					items[i][2] += 1
					break
				elif item_pos == Vector2i(-1,-1):
					items[i][2] += 1
					items[i][0] = tile_pos[0]
					items[i][1] = tile_pos[1]
					break

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get("name") != "TileMap":
		body_in = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.get("name") != "TileMap":
		body_in = false
