class_name EnemyStateStun extends EnemyState

@export var anim_name :String = "stun"
@export var knockback_speed:float = 200.0
@export var decelerate_speed :float =10.0

@export_category("AI ")
@export var next_state :EnemyState

var _animation_finished:bool = false
var _direction:Vector2
var _damage_position:Vector2

func _ready() -> void:
	pass # Replace with function body.

func init()->void:
	enemy.enemy_damaged.connect(_on_enemy_damaged)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Enter()->void:
	enemy.invulnerable =true
	_animation_finished = false
#	获取敌人指向对player的方向 是一个向量 这样 我们就有了击退方向
	_direction = enemy.global_position.direction_to(_damage_position)
	#_direction = enemy.DIR_4[rand]
	enemy.velocity = _direction*-knockback_speed
	enemy.set_direction(_direction)
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	pass

func Exit()->void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	pass
#每帧逻辑
func Process(_delta:float)->EnemyState:
	if _animation_finished == true:
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed*_delta
	
	
	return null
#物理行为更新
func Physics(_delta:float)->EnemyState:
	return	null
	
func _on_enemy_damaged(hurt_box:HurtBox)->void:
#	获取攻击盒子的位置
	_damage_position = hurt_box.global_position 
	state_machine.change_state(self)

func _on_animation_finished(I_a:String)->void:
	_animation_finished =true
	
