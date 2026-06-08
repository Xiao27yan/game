
class_name PlayerStateMachine extends Node

var states :Array[State]
var prev_state :State 
var current_state :State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode=Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.



func _process(delta) -> void:
#每一帧问当前状态：
#你要不要切换到别的状态？
#如果返回 null：保持当前状态
#如果返回另一个 State：切换过去
	ChangeState(current_state.Process(delta))
	pass
	
func _physics_process(delta):
	ChangeState(current_state.Physics(delta))
	pass
	
func _unhandled_input(event):
	ChangeState(current_state.HandleInput(event))
	pass

func Initialize(_player:Player)->void:
	states = []
#	看看状态机里面有什么状态	
	for c in get_children():
		if c is State:
			states.append(c)
				
	if states.size()==0:
		return
#	把第一个状态设置为进入游戏时的Plyer
	states[0].player =_player 
	states[0].state_machine = self
	
	for state in states:
		state.Init()
#这步很关键这步和上步合起来 把player挂给了idle  然后进入idle状态 再调用idle.player里的方法
	ChangeState(states[0])
	process_mode = Node.PROCESS_MODE_INHERIT
			
	
func ChangeState(new_state:State)->void:
	if new_state == null || new_state == current_state:
		return
		#当有新状态传入的时候 就先退出当前状态(如果有状态的话)
	if current_state:
		current_state.Exit()
	prev_state = current_state
	current_state = new_state
	current_state.Enter()
	
