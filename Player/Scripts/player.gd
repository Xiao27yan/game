class_name Player extends CharacterBody2D

var direction:Vector2 = Vector2.ZERO
const DIR_4 = [Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT,Vector2.UP]
var cardinal_direction:Vector2=Vector2.DOWN 

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
	
signal DirectionChanged(new_direction:Vector2)

func _ready(): 
	PlayerManager.player = self
	state_machine.Initialize(self)
	pass

func _process(delta: float) -> void:
#每一帧当前输入方向比如按D就是Vector.RIGHT
	#direction = Input.get_vector("left","right","up","down").normalized()
	#
	direction = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up","down")
	).normalized()
	pass

func _physics_process(delta: float) -> void:
	
#这是Character2D根据velocity移动的方法
	move_and_slide()

func SetDirection() -> bool:
	var new_dir:Vector2=cardinal_direction
	if direction == Vector2.ZERO:
		return false
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x <0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y<0 else Vector2.DOWN
		
	if new_dir == cardinal_direction :
		return false
	cardinal_direction = new_dir
	DirectionChanged.emit(new_dir)
	#是否镜像左右翻转
	sprite_2d.scale.x=-1 if cardinal_direction == Vector2.LEFT else 1		
			
	return true
	

func UpdateAnimation(state:String) -> void:
	animation_player.play(state+"_"+AnimDirecition())
	pass

func AnimDirecition()->String:
	if	cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
