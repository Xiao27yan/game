#在项目设置里做了自动加载
extends Node
signal  level_load_started
signal  level_loaded
signal tilemap_bounds_changed(bounds:Array[Vector2])


var current_tilemap_bounds :Array[Vector2]
var target_transition:String
var position_offset:Vector2

#把关卡变换的信息发送出去
signal TileMapBoundChanged(bounds:Array[Vector2])

func _ready()->void:
	await get_tree().process_frame
	level_loaded.emit()

func ChangeTilemapBounds(bounds:Array[Vector2])->void:
	current_tilemap_bounds = bounds
	TileMapBoundChanged.emit(bounds)
	

func load_new_level(
	level_path:String,
	_target_transition:String,
	_position_offset:Vector2,
)->void:
	#先暂停游戏，防止切换场景时玩家还能移动或触发其他事件。
	get_tree().paused = true
	target_transition = _target_transition	
	position_offset = _position_offset
	
	await SceneTransition.fade_out()
	
	level_load_started.emit()
	#等一帧，让上面的信号和 queue_free() 都处理完，再执行切换场景。
	await get_tree().process_frame
#	改变主场景
	get_tree().change_scene_to_file(level_path)
	
	await SceneTransition.fade_in()

	get_tree().paused = false
	await get_tree().process_frame
	
	level_loaded.emit()
	
	
	
	
	pass
