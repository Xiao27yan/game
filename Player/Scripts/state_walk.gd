class_name State_Walk extends State

@export var move_speed:float =200.0 
# Called when the node enters the scene tree for the first time.
@onready var idle: State_Idle = $"../Idle"
@onready var attack: State = $"../Attack"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func Enter()->void:
	player.UpdateAnimation("walk")
	pass

func Exit()->void:
	pass
#每帧逻辑
#每帧都在判断要不要换状态 并且让他移动
func Process(_delata:float)->State:
	if player.direction ==Vector2.ZERO:
		return idle
		
	if Input.is_action_pressed("shift"):
		move_speed =400
	else:
		move_speed = 200
	
	player.velocity = player.direction *move_speed
	if player.SetDirection():
		player.UpdateAnimation("walk")
	return null
#物理行为更新
func Physics(_delta:float)->State:
	return	null
	
func HandleInput(_event:InputEvent)->State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
	
