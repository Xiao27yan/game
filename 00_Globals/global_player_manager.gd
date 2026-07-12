extends Node
const PLAYER = preload("res://Player/player.tscn")

var player:Player
#player生成
var player_spawned:bool = false

func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.2).timeout


func add_player_instance()->void:
#	instantiate() 会根据 PLAYER 场景生成一个 实际的 Player 节点实例。
	player = PLAYER.instantiate()
	#作为根场景的子节点
	add_child(player)
	pass


func set_health(hp:int,max_hp:int)->void:
	player.hp = hp
	player.max_hp = max_hp
	player.update_hp(0)


func set_player_position(_new_pos:Vector2)->void:
#	将新添加的player坐标转化为之前放置的player_spawn
	player.global_position = _new_pos 
	
	pass
	
func set_as_parent(_p :Node2D)->void:
	if player.get_parent():
		#把player从原本的父节点移除
		player.get_parent().remove_child(player)
#		添加到playground下
	_p.add_child(player)
	
func unparent_player(_p:Node2D)->void:
	_p.remove_child(player)
	
