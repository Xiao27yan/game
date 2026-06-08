class_name State_Idle extends State

# Called when the node enters the scene tree for the first time.

@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func Enter()->void:
	player.UpdateAnimation("idle")
	pass
	
func Init()->void:
	return


func Exit()->void:
	pass
#每帧逻辑
#每帧都在判断要不要换状态 
func Process(_delata:float)->State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity=Vector2.ZERO
	return null
#物理行为更新
func Physics(_delta:float)-> State:
	return	null
	
func HandleInput(_event:InputEvent)->State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
	
