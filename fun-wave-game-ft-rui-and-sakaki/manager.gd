extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _switch_to_wave() -> void:
	$"../solve_interface".visible=false
	$"../wave_interface".visible=true


func _go_to_solve() -> void:
	$"../solve_interface".visible=true
	$"../wave_interface".visible=false


func _check_shoot() -> void:
	if $"../solve_interface/HBoxContainer/stuffToSolve/harmonic/input".text=="" or $"../solve_interface/HBoxContainer/stuffToSolve/lambda/input".text=="" or $"../solve_interface/HBoxContainer/stuffToSolve/freq/input".text=="":
		$"../solve_interface/RichTextLabel".text="All fields must be filled to try a shot!"
	else:
		$"../solve_interface".visible=false
		$"../main_game".visible=true
		$"../main_game/shoot_interface".visible=true


func _try_shot() -> void:
	$"../solve_interface/RichTextLabel".text=""
	$"../main_game/shoot_interface/wave".is_being_shot=true
	var result:bool = $"../wave_interface/wave".check_ans()
	print_debug(result)

func _open_wave_machine() -> void:
	$"../main_game".visible=false
	$"../wave_interface".visible=true


func _close_interfaces() -> void:
	$"../main_game".visible=true
	$"../wave_interface".visible=false
