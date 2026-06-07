class_name State_Attack extends State

# Called when the node enters the scene tree for the first time.
var attacking :bool = false
@export_range(1,20,0.5) var decelerate_speed:float = 5.0
#给该节点添加并导出一个attac_sound属性 类型是Audio流 然后再节点处添加音频文件
@export var attack_sound : AudioStream

@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

@onready var hurt_box: HurtBox = %AttackHurtBox
@onready var idle: State_Idle = $"../Idle"
@onready var walk: State = $"../Walk"
#角色动画播放器
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
#武器特效动画播放器
@onready var attack_anim: AnimationPlayer = $"../../Sprite2D/AttackEffectsprite/AnimationPlayer"
#音频播放器 播放时需要加入音频流



# Called every frame. 'delta' is the elapsed time since the previous frame.
func Enter()->void:
	player.UpdateAnimation("attack")
	attack_anim.play("attack_"+player.AnimDirecition())
	#如果攻击动画结束就发送启动EndAttack函数
	animation_player.animation_finished.connect(EndAttack)
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9,1.1)
	audio.play()
	
	attacking = true
	await get_tree().create_timer(0.15).timeout 
#	攻击的时候攻击框出现 需要检测可被攻击物体
	hurt_box.monitoring = true
	pass

func Exit()->void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	#	不攻击的时候攻击框收起 不需要检测可被攻击物体
	hurt_box.monitoring = false
	pass
#每帧逻辑
#每帧都在判断要不要换状态 
func Process(_delata:float)->State:
	player.velocity-=player.velocity *decelerate_speed *_delata
	if attacking ==false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null
#物理行为更新
func Physics(_delta:float)-> State:
	return	null
	
func HandleInput(_event:InputEvent)->State:
	return null

func EndAttack(_newAnimName : String) -> void:
	attacking = false
	
	
