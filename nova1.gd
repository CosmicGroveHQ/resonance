extends Node3D

@onready var core: MeshInstance3D = $Core
@onready var energy: MeshInstance3D = $Energy
@export var core_spin_speed := 0.25
@export var energy_spin_speed := 0.5

var time := 0.0
var resonance_boost := 0.0

#Core settings
var core_base_scale := 0.55
var core_pulse_speed := 1.0
var core_pulse_strength := 0.050

#Energy shell settings
var energy_base_scale := 1.0
var energy_pulse_speed := 2.0
var energy_pulse_strength := 0.08

func _process(delta):
	
	time += delta
	
	#----------------
	#CORE
	#----------------
	
	var core_pulse = (
		1.0 +
		sin(time * core_pulse_speed) *
		core_pulse_strength
	)
	
	core.scale = (
		Vector3.ONE * 
		core_base_scale * 
		(core_pulse - destabilize_boost)
	)
	
	destabilize_boost = move_toward(
		destabilize_boost,
		0.0,
		delta * 2.5
	)
	# -----------------
	# ENERGY SHELL
	# -----------------
	
	var energy_pulse = (
		1.0 + 
		sin(time * energy_pulse_speed) *
		energy_pulse_strength
	)
	energy.scale = (
		Vector3.ONE *
		energy_base_scale *
		(energy_pulse + resonance_boost)
	)
	
	# Slowly bleed resonance away
	resonance_boost = move_toward(
		resonance_boost,
		0.0,
		delta * 1.5
	)
	
	core.rotate_y(core_spin_speed * delta)
	
	energy.rotate_y(energy_spin_speed *delta)
	energy.rotate_x(energy_spin_speed * 0.3 * delta)
	

var destabilize_boost := 0.0
		
func resonate():
	print("NOVA RESONANCE FIRED")
	resonance_boost = 0.80
	
func destabilize():
	destabilize_boost = 0.20
	
