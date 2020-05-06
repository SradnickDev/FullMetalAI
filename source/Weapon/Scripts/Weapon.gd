extends Spatial

signal newProjectileCreated(projectile)


export(String) var projectileName
export(float) var fireRate = 1
export(bool) var randomSpread = false
export(float,0.0,6.3) var spreadRadian  = 0
export(int) var bulletAmount = 1

onready var muzzlePosition = $MuzzlePosition
onready var ready = LazyLink.linkIt(self)

var projectile
var loader setget getResource

func getResource(loader):
	projectile = loader.get_resource(projectileName)

func shoot():
	
	#Audio
	$ShootAudio.play()
	$MuzzleFlash.play()
	#to store current spread
	var radians = 0
	#calculate random spread step
	if randomSpread:
		radians = rand_range(-spreadRadian,spreadRadian)
	else :
		if spreadRadian != 0:
			radians = -(spreadRadian / bulletAmount) * bulletAmount / 2
	#creating and setup bullets
	for i in range(bulletAmount):
		
		#MetaData.addData(self.name,MetaData.ProjectileFired,1)
		var newP = projectile.instance()
		newP.transform = muzzlePosition.global_transform
		newP.rotate_y(radians)
		
		newP.moveDirection = muzzlePosition.global_transform.basis.z.rotated(Vector3(0,1,0),radians)
		
		self.emit_signal("newProjectileCreated",newP)
		
		#calculate random spread step
		if randomSpread:
			radians = rand_range(-spreadRadian,spreadRadian)
		else :
			#increasing radian for a linear spread
			radians += spreadRadian/bulletAmount
		muzzlePosition.rotation.y = 0