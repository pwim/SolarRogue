extends Sprite

# How much to offset background from one end of the map to the other
export(float) var parallax = 0.0

func _ready():
	BehaviorEvents.connect("OnMovement", self, "OnMovement_Callback")
	BehaviorEvents.connect("OnLevelLoaded", self, "OnLevelLoaded_Callback")
	BehaviorEvents.connect("OnTransferPlayer", self, "OnTransferPlayer_Callback")
	
	OnLevelLoaded_Callback()
	

func OnMovement_Callback(obj, dir):
	if obj.get_attrib("type") == "player":
		_update_parallax(obj)
		
func OnLevelLoaded_Callback():
	_update_parallax(Globals.LevelLoaderRef.objByType["player"][0])
	
func OnTransferPlayer_Callback(old_player, new_player):
	_update_parallax(new_player)

func _update_parallax(obj):
	var bounds = Globals.LevelLoaderRef.levelSize
	var tile_size = Globals.LevelLoaderRef.tileSize
	var grid_span = bounds * tile_size
	
	var default_pos = grid_span / 2.0
	var player_pos = obj.position
	var offset_from_center = player_pos - default_pos
	var offset_per_pix = Vector2(parallax, parallax) / default_pos
	var cur_offset = offset_per_pix * offset_from_center
	self.position = default_pos + cur_offset
	get_node("Occlusion").position = -cur_offset
	