class_name EnemyStateIdle extends EnemyState

@export var anim_name :String = "idle"

@export_category("AI ")
@export var state_duration_min :float=0.5
@export var state_duration_max :float=1.5
@onready var after_idle_state: EnemyState = $"../Wander"

var _timer : float = 0.0

func _ready() -> void:
	pass # Replace with function body.

func init()->void:
	pass

#
func Enter()->void:
	enemy.velocity = Vector2.ZERO
#	设置一个有区间的随机计时器 用来播放enemy的idle状态
	_timer = randf_range(state_duration_min,state_duration_max)
	enemy.update_animation(anim_name)
	pass

func Exit()->void:
	pass
#每帧逻辑
#idle状态倒计时结束了 就返回Wander状态
func Process(_delata:float)->EnemyState:
	_timer-=_delata
	if _timer<=0:
		return after_idle_state 
	return null
#物理行为更新
func Physics(_delta:float)->EnemyState:
	return	null
	
