class_name Enemy extends CharacterBody2D
#方向改变信号
signal direction_changed(new_direction:Vector2)
#攻击信号 发送对人物造成的伤害
signal enemy_damaged(hurt_box:Area2D)
signal	enemy_destroyed(hurt_box:Area2D)

const DIR_4 = [Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT,Vector2.UP]
@export var hp :int =3
#当前方向
var cardinal_direction:Vector2 = Vector2.DOWN
#移动方向
var direction :Vector2 = Vector2.ZERO
var player:Player
var invulnerable:bool = false	

@onready var hit_box :HitBox =$HitBox
@onready var animation_player :AnimationPlayer =$AnimationPlayer
@onready var sprite:Sprite2D = $Sprite2D
#@onready var hit_box :HitBox =$HitBox
@onready var state_machine:EnemyStateMachine=$EnemyStateMachine
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	把自己传给状态机
	state_machine.initialize(self)
	player = PlayerManager.player
	hit_box.Damaged.connect(_take_damage)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
func set_direction(_new_direction:Vector2)->bool:
	var new_dir = cardinal_direction
	if _new_direction == Vector2.ZERO:
		return false
	elif _new_direction.y==0:
		new_dir = Vector2.LEFT if _new_direction.x<0 else  Vector2.RIGHT
	elif _new_direction.x == 0:
		new_dir = Vector2.UP if _new_direction.y<0 else  Vector2.DOWN
	elif _new_direction == cardinal_direction:
		return false
	cardinal_direction = new_dir
	direction_changed.emit(new_dir)
	sprite.scale.x=-1 if cardinal_direction == Vector2.LEFT else 1	
	return true	
	
func anim_direction()->String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction ==Vector2.UP:
		return "up"
	else:
		return "side"
func update_animation(state:String)->void:
	animation_player.play(state + "_" + anim_direction())

func _take_damage(hurt_box:Area2D)->void:
	if invulnerable ==true:
		return 
	hp -= hurt_box.damage
	if hp>0:
		#发送信号给stun状态
		enemy_damaged.emit(hurt_box)
	else:
		#发送信号给销毁状态
		enemy_destroyed.emit(hurt_box)
	return
