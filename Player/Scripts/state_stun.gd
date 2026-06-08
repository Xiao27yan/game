class_name State_Stun extends State
@export var knockback_speed:float =200.0
@export var decelerate_speed:float =10.0 
@export var invulnerable_duration:float =1.0 
# Called when the node enters the scene tree for the first time.
@onready var idle: State_Idle = $"../Idle"


var hurt_box:HurtBox
var direction:Vector2
var next_state:State = null
# Called every frame. 'delta' is the elapsed time since the previous frame.

func Init()->void:
	player.player_Damaged.connect(_player_damaged)


func Enter()->void:
	player.animation_player.animation_finished.disconnect(_animation_finished)
	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity =direction*-knockback_speed
	player.SetDirection()
	player.UpdateAnimation("stun")
	player.make_invulnerable(invulnerable_duration)
	
	player.animation_player.animation_finished.connect(_animation_finished)
	pass

func Exit()->void:
	next_state = null
#	player受击后 传递signal 调用machine的ChangeState(stun)方法 进入stun状态 然后设置 朝向 与 反向位移 最后播放动画  无敌帧过后 动画播放结束可以转向下一个状态 _animation_finished方法负责 
	player.effect_animation_player.play("damaged")
	pass
#每帧逻辑


func Process(_delata:float)->State:
	player.velocity -= player.velocity*decelerate_speed*_delata
	return next_state
#物理行为更新
func Physics(_delta:float)->State:
	return	null
	
func HandleInput(_event:InputEvent)->State:

	return null
	
func _player_damaged(_hurt_box:HurtBox)->void:
	hurt_box = _hurt_box
	#只有收到伤害才主动改变状态
	state_machine.ChangeState(self)
	pass

#一开始newxState是空 也就是说 状态机执行change_state的时候会保持stun状态 一但动画完成 next_state就被设置成了idle 就可以下一个
func _animation_finished(_a:String)->void:
	next_state = idle
