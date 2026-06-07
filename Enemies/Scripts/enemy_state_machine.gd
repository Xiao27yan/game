class_name EnemyStateMachine extends Node
var states :Array [EnemyState]
var pre_state:EnemyState
var current_state:EnemyState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	避免在准备开始时 执行任何逻辑
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	change_state(current_state.Process(_delta))
	pass
	
func _physics_process(delta: float) -> void:
	change_state(current_state.Physics(delta))
	pass
		
#		初始化的时候把enemy的每个状态都放到states数组里 然后将每一个状态的enmey设置成slime  
func initialize(_enemy:Enemy)->void:
	states = []
	for c in get_children():
		states.append(c)
		
	for s in states:
		s.enemy = _enemy
		s.state_machine =self
		#enemy的每个状态都要init
		s.init()
		
	if states.size()>0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT
		
		
	

#检查需不需要更换状态
func change_state(new_state:EnemyState)->void:
	if new_state == null ||new_state == current_state:
		return
	if current_state:
		current_state.Exit()
		
	pre_state = current_state
	current_state = new_state
	current_state.Enter()
		
