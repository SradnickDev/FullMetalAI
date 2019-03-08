extends "res://Enemy/Scripts/Enemy.gd"

export(float,0,1) var transparency = 0.2

var material
var defaultColor
var detected = false

func _ready():
	duplicateMaterial()

#duplicate Material, to make changes only on this instance
func duplicateMaterial():
	material = $MeshInstance.get_surface_material(0)
	defaultColor = material.albedo_color
	$MeshInstance.set_surface_material(0,material)

#changes the Color if detected 
func detected(detected):
	self.detected = detected
	if detected:
		material.albedo_color = Color(0,0,0,transparency)
	else:
		material.albedo_color = defaultColor