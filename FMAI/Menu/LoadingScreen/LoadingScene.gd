extends TextureRect

export(Array,String) var tips = []
var thread = Thread.new()
var loadedScene

#Start background loading a Scene
#display random tip
func loadScene(scenePath):
	$Tips.text = tips[rand_range(0,tips.size()-1)]
	thread.start(self,"loading",ResourceLoader.load_interactive(scenePath,"PackedScene"))

func loading(interactivLoader):
	while(true):
		var err = interactivLoader.poll()
		if err == ERR_FILE_EOF:
			call_deferred("setScene")
			return interactivLoader.get_resource()

# wait for the thread to finish
func setScene():
	loadedScene = thread.wait_to_finish()
	
	syncVisualServer()
	get_tree().change_scene_to(loadedScene)
	call_deferred("moveScene")
	startAnimation()

func syncVisualServer():
	VisualServer.sync()
	OS.delay_usec(16000)

#To render it on top
func moveScene():
	var childCount = get_tree().root.get_child_count()
	get_tree().root.move_child(self,childCount)

func startAnimation():
	$AnimationPlayer.play("FadeOut")

func onAnimationPlayerAnimationFinished(animName):
	if animName == "FadeOut":
		self.queue_free()
