#让脚本在编辑器中运行 意思是 编辑器中（也就是侧边栏）做了改变 能实时更新
@tool 

class_name LevelTransition extends Area2D

enum SIDE {LEFT,RIGHT,TOP,BOTTOM}
@onready var collision_shape:CollisionShape2D =$CollisionShape2D 

#跳转到目标场景文件
@export_file("*tscn") var level

#跳转到目标场景中 传送门的名称
@export var target_transition_area:String = "LevelTransition"

@export_category("Collision Area Settings")

@export_range(1,12,1,"or_greater") var size :int =2:
	set(_v):
		size = _v
		_update_area()
		

@export var side:SIDE = SIDE.LEFT:
	set(_v):
		side = _v
		_update_area()

	
func _ready() -> void:
	_update_area()
	#true 表示当前在编辑器里执行 false 表示游戏运行时
	if Engine.is_editor_hint():
		return
	monitoring = false
	_place_player()
	await LevelManager.level_loaded
	
	monitoring=true
	
#	有物体进入的时候就调用player_entered
	body_entered.connect(_player_entered)	
	
		
		
	body_entered.connect(_player_entered)
	pass 
	
func _player_entered(_p:Node2D)->void:
	#把关卡 目标区域（下一个关卡的位置） 还有 坐标传给关卡管理器
	LevelManager.load_new_level(level,target_transition_area,get_offset())
	pass
	
#	?
func _place_player()->void:
	if name!=LevelManager.target_transition:
		return
	PlayerManager.set_player_position(global_position+LevelManager.position_offset)
	
#	?
func get_offset()->Vector2:
	var offset:Vector2 = Vector2.ZERO
	#获取玩家坐标
	var player_pos = PlayerManager.player.global_position
	
	if side ==SIDE.LEFT or side == SIDE.RIGHT:
		offset.y =player_pos.y - global_position.y
		offset.x = 16
		if side ==SIDE.LEFT:
			offset.x *=-1
	else:
		offset.x =player_pos.y - global_position.y
		offset.y = 16
		if side ==SIDE.LEFT:
			offset.y *=-1
		
	return offset
	
func _update_area()->void:
	var new_rect:Vector2 = Vector2(32,32)
	var new_position:Vector2 = Vector2.ZERO
	
	if side ==SIDE.TOP:
		new_rect.x *=size
		new_position.y -=16
	elif side == SIDE.BOTTOM:
		new_rect.x *=size
		new_position.y +=16
	elif side == SIDE.LEFT:
		new_rect.y *=size
		new_position.x -=16
	elif side == SIDE.RIGHT:
		new_rect.y *=size
		new_position.x +=16
		
	if collision_shape == null:
		return
	
	if collision_shape.shape == null:
		return
		
	
	collision_shape.shape.size = new_rect
	collision_shape.position = new_position



	#func _snap_to_grid()->void:
		#position.x = round(position.x/16)*16
		#position.y = round(position.y/16)*16
