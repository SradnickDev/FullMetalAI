extends Node

var inputDir = Vector3()
var rotation = 0

func processInput():

	inputDir = Vector3()
	if hasController():
		
		if yJoyAxisLeftStick() != 0:
			inputDir.z += yJoyAxisLeftStick()
		if xJoyAxisLeftStick() != 0:
			inputDir.x += xJoyAxisLeftStick()
	else:
		inputDir.z += yAxisKey()
		inputDir.x += xAxisKey()
	
	return inputDir.normalized()

func hasController():
	return true if Input.get_connected_joypads().size() > 0 else false 

func rightStickRotation():
	var xAxis = Input.get_joy_axis(0,JOY_AXIS_2)
	var yAxis = Input.get_joy_axis(0,JOY_AXIS_3)
	
	if abs(xAxis) > 0.3 || abs(yAxis) > 0.3:
		rotation = atan2(xAxis,yAxis)
	return rotation

func xJoyAxisLeftStick():
	var xAxis = Input.get_joy_axis(0,JOY_AXIS_0)
	return xAxis if abs(xAxis) >= 0.3 else 0

func yJoyAxisLeftStick():
	var yAxis = Input.get_joy_axis(0,JOY_AXIS_1)
	return yAxis if abs(yAxis) >= 0.3 else 0

func xAxisKey():
	var xAxis = 0
	if Input.is_action_pressed("Left"):
		xAxis = -1
	if Input.is_action_pressed("Right"):
		xAxis = 1
	return xAxis

func yAxisKey():
	var yAxis = 0
	if Input.is_action_pressed("Up"):
		yAxis = -1
	if Input.is_action_pressed("Down"):
		yAxis = 1
	return yAxis