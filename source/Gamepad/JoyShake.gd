extends Node

var device

func startShake(time,magnitude):
	if !isConnected(): return
	
	getDevice()
	
	time = checkTime(time)
	
	stopShake()
	
	Input.start_joy_vibration(device,magnitude.x,magnitude.y,time)

func checkTime(time):
	if time < 0.5:
		return 0.5
	return time

func getDevice():
	device  = Input.get_connected_joypads()[0]

func stopShake():
	Input.stop_joy_vibration(device)

func isConnected():
	return true if Input.get_connected_joypads().size() > 0 else false 