extends Node3D

@export var orbit_speed := 0.9
@export var pull_speed := 7
@export var respawn_delay := 1

@onready var glyph: Label3D = $Glyph
@onready var nova = $"../Nova"
@onready var absorb_target: Marker3D = $"../Nova/AbsorbTarget"

var is_resonating : bool = false
var is_absorbed: bool = false

var starting_position: Vector3
var starting_text: String

var glyph_data = [
	{
		"symbol": "Δ",
		"action": "glyph_a"
	},
	{
		"symbol": "🔺",
		"action": "glyph_s"
	},
	{
		"symbol": "▫️",
		"action": "glyph_d"
	},
	{
		"symbol": "🔸",
		"action": "glyph_f"
	}
]

var glyph_actions = [
	"glyph_a",
	"glyph_s",
	"glyph_d",
	"glyph_f"
]

var current_glyph ={}

func _ready():
	starting_position = glyph.position
	choose_new_glyph()
	
func choose_new_glyph():
	current_glyph = glyph_data.pick_random()
	glyph.text = current_glyph["symbol"]

func _process(delta):

	# Keep the orbit rotating at all times
	rotate_z(orbit_speed * delta)

	# -------------------------
	# WAITING FOR PLAYER INPUT
	# -------------------------
	if not is_resonating:

		# Correct glyph
		if Input.is_action_just_pressed(current_glyph["action"]):
			is_resonating = true
			print("CORRECT GLYPH")

		# Wrong glyph
		else:
			for action in glyph_actions:

				if action != current_glyph["action"]:

					if Input.is_action_just_pressed(action):
						nova.destabilize()
						print("WRONG GLYPH")

	# ------------------------- 
	 
	
	
	  
	# GLYPH IS BEING ABSORBED
	# -------------------------
	else:

		if not is_absorbed:

			glyph.global_position = glyph.global_position.move_toward(
				absorb_target.global_position,
				pull_speed * delta
			)

			if glyph.global_position.distance_to(absorb_target.global_position) < 0.05:

				is_absorbed = true
				glyph.text = ""

				nova.resonate()

				print("GLYPH ABSORBED")

				reset_glyph()
func reset_glyph():
	
	await get_tree().create_timer(respawn_delay).timeout
	
	glyph.position = starting_position
	
	choose_new_glyph()
	
	is_resonating = false
	is_absorbed = false
