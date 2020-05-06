extends LineEdit

var config = ConfigFile.new()

func loadName():
	var err = config.load("user://settings.cfg")
	var id = randi()%100
	var userName = str("user",id)
	
	self.text = config.get_value("User","Name",userName)

func saveName():
	var name = self.text
	if name != "" || name != " ":
		config.set_value("User","Name",name)
		config.save("user://settings.cfg")