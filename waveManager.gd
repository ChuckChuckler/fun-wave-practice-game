extends Node2D

const FREQ:float=2.0
const WAVELENGTH:float=1000.0
const POINT_COUNT:int=100

var harmonic:int=1
var amp:float=75.0
var coeffL:int=2 #2 if open on both ends, 4 if open on one

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
	
func set_harmonic()->void:
	harmonic = randi_range(1,5)
	

func update_wave()->void:
	var points = PackedVector2Array()
	var step = WAVELENGTH/POINT_COUNT
	
	for i in range(POINT_COUNT):
		var x:float=i*step
		var k = TAU/((WAVELENGTH*2)/harmonic)
		var w = TAU*FREQ
		var y = 2.0*amp*sin(k*x)*cos(w*time)
		
		points.append(Vector2(x+60,y+(get_viewport().size.y/2)))	
	$lambda.points=points


func _create_new_wave() -> void:
	set_harmonic()
	amp=randi_range(75,125)
