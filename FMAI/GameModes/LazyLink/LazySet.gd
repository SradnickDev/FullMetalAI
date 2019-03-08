
class PropertyValue:
	var name
	var value

	func _init(name,value):
		self.name = name
		self.value = value

#retriev Variables from a File back to its Nodes
static func setVariables(node,filePath,separator,cachedVariables):
	if cachedVariables.size() == 0:
		cachedVariables = read(filePath,separator,cachedVariables)
	
	var nodeName
	
	if "@" in node.name:
		nodeName = node.name.split("@")
		nodeName = nodeName[1]
	elif "#" in node.name:
		nodeName = node.name.split("#")
		nodeName = nodeName[0]
	else:
		nodeName = node.name
		
	if not cachedVariables.has(nodeName): return

	for variables in cachedVariables:

		if variables == nodeName:

			for property in cachedVariables[variables]:
				var type = typeof(node.get(property.name))
				var propValue = property.value
				var value = toType(type,propValue)
				node.set(property.name,value)


#Read the File and convert them to a Dictionary
static func read(filePath,separator,cachedVariables):
	var data = File.new()
	data.open(filePath,File.READ)
	data.seek(1)
	while  not data.eof_reached():

		var line = data.get_line()
		var t = line.split(separator,false)

		if t.size() > 3:
			var nodeName = t[0]
			var property = t[1]
			var value = t[2]
			var prop = PropertyValue.new(property,value)

			if not cachedVariables.has(nodeName):
				cachedVariables[nodeName] = []
			cachedVariables[nodeName].append(prop)

	data.close()
	return cachedVariables

#convert strings to given Type
static func toType(type,value):
	match type:
		1:
			if str(value) == "True":
				return true
			if str(value) == "False":
				return false

		2:	return int(value)
		3:	return float(value)
		4:	return str(value)
		5:
			var t = value.split(",",false)
			var x = t[0].split("(")[1]
			var y = t[1].split(")")[0]
			return Vector2(x,y)
		7:
			var t = value.split(",",false)
			var x = t[0].split("(")[1]
			var y = t[1]
			var z = t[2].split(")")[0]
			return Vector3(x,y,z)