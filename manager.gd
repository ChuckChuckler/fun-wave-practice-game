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
