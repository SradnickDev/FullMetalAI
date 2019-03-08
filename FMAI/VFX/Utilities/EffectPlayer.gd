extends Spatial

export(bool) var useAnimationPlayer = true # True animation will be used, false Particles
export(String) var animationName
export(bool) var oneShot = true #Animation or Particles
export(bool) var destroyOnFinished = false #only Animation
export(bool) var forceRestart = false

var animationPlayer
var particle

func _ready():
	init()

func init():
	if useAnimationPlayer:
		getAnimationPlayer()
		setAnimationOneShot()
	else:
		setParticleToOneShot()

func setAnimationOneShot():
	animationPlayer.get_animation(animationName).loop = !oneShot
	
func setParticleToOneShot():
	for child in get_children():
		if child.is_class("Particle"):
			child.one_shot()
	
func getAnimationPlayer():
	for child in get_children():
		if child.is_class("AnimationPlayer"):
			animationPlayer = child
			if destroyOnFinished:
				animationPlayer.connect("animation_finished",self,"onFinished")

func play():
	if useAnimationPlayer:
		if animationPlayer.is_playing(): return
		animationPlayer.play(animationName)
	else:
		playParticles()
		
func playParticles():
	for child in get_children():
		if child.is_class("Particles"):
			if forceRestart:
				child.emitting = false
			child.emitting = true

func stop():
	for child in get_children():
		if child.is_class("AnimationPlayer"):
			child.stop(true)
		if child.is_class("Particles"):
			child.emitting = false

func onFinished(name):
	queue_free()