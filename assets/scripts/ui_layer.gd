extends TileMapLayer

@onready var path_layer: TileMapLayer = $"../PathLayer"
var tower_scene = preload("res://assets/scenes/node_2d.tscn") # TODO: Change to actual tower scene

var is_active = false # control selection ui
var last_hover = null # the last mouse hover position
var path_neighbors: Array[Vector2i] = []
var placed_towers: Array[Vector2i] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	path_neighbors = get_path_neighbors() # initialize path neighbors

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_active:
		on_hover_tile()

func _input(event):
	if is_active:
		if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				var cur_tile = get_hovered_tile()
				if is_valid_tile(cur_tile):
					place_tower(cur_tile)
					print("Tower placed")
				else:
					print("Tower couldn't be placed. Maybe the tile is blocked by another tower or the position is invalid.")

func on_hover_tile():
	var cur_hover = get_hovered_tile()
	if last_hover != cur_hover:	
		if last_hover != null:
			erase_cell(last_hover)		
		if is_valid_tile(cur_hover):
			# set_cell(coords, source_id, atlas_coords, alternative tile)
			set_cell(cur_hover, 0, Vector2i(0,0), 0)
		last_hover = cur_hover

func get_hovered_tile():
	return local_to_map(get_local_mouse_position())

func is_valid_tile(tile: Vector2i):
	return tile in path_neighbors and tile not in placed_towers

func get_path_neighbors():
	var NEIGHBOR_TYPES = [TileSet.CELL_NEIGHBOR_RIGHT_SIDE, TileSet.CELL_NEIGHBOR_LEFT_SIDE, TileSet.CELL_NEIGHBOR_TOP_SIDE, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE]
	var neighbors: Array[Vector2i] = []
	for tile in path_layer.get_used_cells():
		for type in NEIGHBOR_TYPES:
			var cur_neighbor = path_layer.get_neighbor_cell(tile, type)
			if cur_neighbor not in neighbors and cur_neighbor not in path_layer.get_used_cells():
				neighbors.append(cur_neighbor)
	return neighbors

func place_tower(tile):
	var tower = tower_scene.instantiate()
	tower.global_position = map_to_local(tile)
	$"../".add_child(tower)
	placed_towers.append(tile)
	erase_cell(tile) # Remove selection marker
