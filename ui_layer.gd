extends TileMapLayer

@onready var path_layer: TileMapLayer = $"../PathLayer"

var is_active = false # control selection ui
var last_hover = null # the last mouse hover position
var path_neighbors: Array[Vector2i] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_active = true
	path_neighbors = get_path_neighbors()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_active:
		on_hover_tile()

func _input(event):
	if is_active:
		if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				if get_hovered_tile() in path_neighbors:
					print("Valid!")
					pass # todo: load selected tower and place it at map_to_local(get_hovered_tile)

func on_hover_tile():
	var cur_hover = get_hovered_tile()
	if last_hover != cur_hover:	
		if last_hover != null:
			erase_cell(last_hover)		
		if cur_hover in get_path_neighbors():
			# set_cell(coords, source_id, atlas_coords, alternative tile)
			set_cell(cur_hover, 0, Vector2i(0,0), 0)
		last_hover = cur_hover

func get_hovered_tile():
	return local_to_map(get_local_mouse_position())

func get_path_neighbors():
	var NEIGHBOR_TYPES = [TileSet.CELL_NEIGHBOR_RIGHT_SIDE, TileSet.CELL_NEIGHBOR_LEFT_SIDE, TileSet.CELL_NEIGHBOR_TOP_SIDE, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE]
	var neighbors: Array[Vector2i] = []
	for tile in path_layer.get_used_cells():
		for type in NEIGHBOR_TYPES:
			var cur_neighbor = path_layer.get_neighbor_cell(tile, type)
			if cur_neighbor not in neighbors and cur_neighbor not in path_layer.get_used_cells():
				neighbors.append(cur_neighbor)
	return neighbors
