extends Panel

export(Texture) var page1
export(Texture) var page2
export(Texture) var page3
export(Texture) var page4
export(Texture) var page5
export(Texture) var page6

export(NodePath) var closeFocus

onready var pages = [page1,page2,page3,page4,page5,page6]
onready var header = ["Controls","Controls","Weapons","Interactable - Obstacles","Power Ups","Enemies"]

var currentPage = 0

func _ready():
	reset()

func onOpenBtnPressed():
	reset()
	$NextBtn.grab_focus()
	self.visible = true
	
func onCloseBtnPressed():
	if closeFocus != "":
		get_node(closeFocus).grab_focus()
	self.visible = false

func onNextBtnPressed():
	currentPage = (currentPage + 1) % pages.size()
	setPage()

func onPreviousBtnPressed():
	currentPage = (currentPage - 1) % pages.size()
	setPage()

func setPage():
	$TextureRect.texture = pages[currentPage]
	var idx = pages.find(pages[currentPage])
	$PageCount.text = str(idx+1," / ",pages.size())
	$Header.text = header[currentPage]

func reset():
	currentPage = 0
	setPage()