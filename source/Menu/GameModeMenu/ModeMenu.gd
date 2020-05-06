extends Control

signal modePicked(name,description,btn)
signal preview(name,description)
signal deselect()

export(NodePath) var onCloseFocus
var selectedModeButton

func _ready():
	connectDefaultMode()
	connectModeButtons()
	$Panel/VBoxContainer/RegularButton.onButtonPressd()
	$Panel/VBoxContainer/RegularButton.onFocusEntered()
	self.visible = false

func connectDefaultMode():
	$Panel/VBoxContainer/RegularButton.connect("focusEntered",self,"onPreview")
	$Panel/VBoxContainer/RegularButton.connect("focusExited",self,"onDeselect")
	$Panel/VBoxContainer/RegularButton.connect("modePicked",self,"onModePicked")

func connectModeButtons():
	for child in $Panel/VBoxContainer/Modes.get_children():
		for button in child.get_children():
			button.connect("focusEntered",self,"onPreview")
			button.connect("focusExited",self,"onDeselect")
			button.connect("modePicked",self,"onModePicked")

func openClose():
	self.visible = !self.visible
	if visible:
		$Panel/VBoxContainer/RegularButton.grab_focus()
	else:
		get_node(onCloseFocus).grab_focus()

func onPreview(name,description):
	emit_signal("preview",name,description)

func onDeselect():
	emit_signal("deselect")

func onModePicked(name,description,btn):
	$ModeSelectedAudio.play()
	setSelectedModeButton(btn)
	emit_signal("modePicked",name,description)
	
func setSelectedModeButton(button):
	if button != selectedModeButton:
		#button.modulate = Color(0,1,0,1)
		button.disabled = true
		
		
		if selectedModeButton != null:
			#selectedModeButton.modulate = Color(1,1,1,1)
			selectedModeButton.disabled = false
			
		selectedModeButton = button