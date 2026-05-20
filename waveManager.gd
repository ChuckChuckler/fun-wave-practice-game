extends Node2D

#these are for the wave's appearance and don't change
const FREQ:float=1.5
const WAVELENGTH:float=1000.0
const POINT_COUNT:int=100

#these change with each question
var harmonic:int=1
var amp:float=75.0
var coeffL:int=2 #2 if open on both ends, 4 if open on one
var len_sample:float=0.5 #in m
var sound_speed:float=340.0 #m/s

var time:float=0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$equil.points[0].y=(get_viewport().size.y/2)
	$equil.points[1].y=(get_viewport().size.y/2)
	_create_new_wave()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time+=delta
	update_wave()

func update_wave()->void:
	var points = PackedVector2Array()
	var step = WAVELENGTH/POINT_COUNT
	
	for i in range(POINT_COUNT):
		var x:float=i*step
		var k = TAU/((WAVELENGTH*coeffL)/harmonic)
		var w = TAU*FREQ
		var y = 2.0*amp*sin(k*x)*cos(w*time)
		
		points.append(Vector2(x+60,y+(get_viewport().size.y/2)))	
	$lambda.points=points


func _create_new_wave() -> void:
	coeffL = randi_range(1,2)*2
	len_sample=randi_range(10,100)/100.0
	sound_speed=randi_range(3000,4000)/10.0
	amp=randi_range(75,125)
	
	$"../../solve_interface/HBoxContainer/info/length".text="Length shown: " + str(len_sample) + " m"
	$"../../solve_interface/HBoxContainer/info/speedOfSound".text="Speed of medium right now: " + str(sound_speed) + " m/s"
	if coeffL==2:
		$"../../solve_interface/HBoxContainer/info/typeOfPipe".text="Both sides open"
		harmonic = randi_range(1,5)
	else:
		$"../../solve_interface/HBoxContainer/info/typeOfPipe".text="One side open"
		harmonic = (randi_range(1,5)*2)-1
	
func calculate()->Dictionary:
	var lmb:float=(len_sample*coeffL)/harmonic
	return {
		"harmonic":harmonic,
		"lambda":lmb,
		"freq":sound_speed/lmb
	}

func check_ans()->bool:
	var harmonicIsCorrect:bool=false
	var lambdaIsCorrect:bool=false
	var freqIsCorrect:bool=false
	
	var result = calculate()
	
	if $"../../solve_interface/HBoxContainer/stuffToSolve/harmonic/input".text == str(harmonic):
		harmonicIsCorrect=true
	
	if $"../../solve_interface/HBoxContainer/stuffToSolve/lambda/input".text >= str(result.lambda-0.2) and $"../../solve_interface/HBoxContainer/stuffToSolve/lambda/input".text <= str(result.lambda+0.2):
		lambdaIsCorrect=true
	
	if $"../../solve_interface/HBoxContainer/stuffToSolve/freq/input".text >= str(result.freq-0.2) and $"../../solve_interface/HBoxContainer/stuffToSolve/freq/input".text <= str(result.freq+0.2):
		freqIsCorrect=true
	
	return harmonicIsCorrect and lambdaIsCorrect and freqIsCorrect
