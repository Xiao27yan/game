class_name PlayerCamera extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.TileMapBoundChanged.connect(UpdateLimits)
	UpdateLimits(LevelManager.current_tilemap_bounds)
	pass # Replace with function body.

#该函数传入一个数组 一个是左上角的awDDDDDDDDWa 一个是右下角
func UpdateLimits(bounds:Array[ Vector2])->void:
	if bounds == []:
		return
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
	
	pass
