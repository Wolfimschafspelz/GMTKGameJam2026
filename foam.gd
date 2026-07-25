extends Node2D

@onready var grass_layer: TileMapLayer = $"../../GrassLayer/GrassBaseLayer"
@onready var foam_sprite: AnimatedSprite2D = $foam

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_foam()

func create_foam():
	var edges = calc_fields()
	for edge in edges:
		var foam = foam_sprite.duplicate()
		foam.global_position = grass_layer.map_to_local(edge)
		foam.play("default")
		add_child(foam)
	foam_sprite.visible = false

func calc_fields():
	var free_edges: Array[Vector2i] = []
	var grass_tiles: Array[Vector2i] = grass_layer.get_used_cells()
	for tile in grass_tiles:
		if is_edge(tile, grass_tiles):
			free_edges.append(tile)
	return free_edges

func is_edge(tile: Vector2i, grass_tiles: Array[Vector2i]):
	return not (
		grass_layer.get_neighbor_cell(tile, TileSet.CELL_NEIGHBOR_TOP_SIDE) in grass_tiles
		and grass_layer.get_neighbor_cell(tile, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE) in grass_tiles
		and grass_layer.get_neighbor_cell(tile, TileSet.CELL_NEIGHBOR_LEFT_SIDE) in grass_tiles
		and grass_layer.get_neighbor_cell(tile, TileSet.CELL_NEIGHBOR_RIGHT_SIDE) in grass_tiles
	)
