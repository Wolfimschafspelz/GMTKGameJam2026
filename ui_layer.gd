extends TileMapLayer

const test_scene = preload("res://test.tscn")

var is_active = false # control selection ui
var last_hover = null # the last mouse hover position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_active:
		on_hover_tile()

func _input(event):
	if is_active:
		if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				pass # todo: load selected tower and place it at map_to_local(get_hovered_tile)

func on_hover_tile():
	var cur_hover = get_hovered_tile()
	if last_hover != null and (last_hover != cur_hover):
		# set_cell(coords, source_id, atlas_coords, alternative tile)
		set_cell(cur_hover, 0, Vector2i(0,0), 0)
		erase_cell(last_hover)		
	elif last_hover == null:
		set_cell(cur_hover, 0, Vector2i(0,0), 0)		
	last_hover = cur_hover

func get_hovered_tile():
	return local_to_map(get_local_mouse_position())
