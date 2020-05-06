
#iterate through all properties in given Node
#and store them in a dictionary
static func getVariables(node,filePath,separator,cachedVariables):

	var variable = []
	var propertyList = node.get_property_list()
	var nodeName = node.name

	#check for instance() / duplication
	if "@" in nodeName:
		nodeName = nodeName.split("@")
		nodeName = nodeName[1]
	if "#" in nodeName:
		nodeName = nodeName.split("#")
		nodeName = nodeName[0]
		
	
	for property in propertyList:
		if verifyProperty(property):
			var propName = property.name
			var propValue = node.get(propName)
			var propType = getType(property.type)
			if propType == "vector3":
				propValue = str("(",propValue.x,",",propValue.y,",",propValue.z,")")
			if propType == "vector2":
				propValue = str("(",propValue.x,",",propValue.y,")")

			var entry = str(nodeName,separator,propName,separator,propValue,separator,propType,separator,"(",propValue,")")
			variable.append(entry)

	cachedVariables[nodeName] = variable
	save(filePath,separator,cachedVariables)
	return cachedVariables

#write given dictionary to a File in an csv kinda format
static func save(filePath,separator,cachedVariables):
	var file = File.new()
	file.open(filePath,File.WRITE)
	var fielHeader = "NodeName;VariableName;Value;Type;DefaultValue"
	var fileCommand = "1 Command;;;;"
	file.store_line(fielHeader)
	file.store_line(fileCommand)

	#iterate through all entries in cachedVariables
	for entry in cachedVariables:

		#each index own line
		for variable in cachedVariables[entry]:
				file.store_line(variable)
		#end of entry split from next entry
		#file.store_line("\n")
	file.close()

#sort the Property after given constrains
static func verifyProperty(property):
	if property.type != TYPE_NODE_PATH and property.type != TYPE_OBJECT and property.usage & PROPERTY_USAGE_SCRIPT_VARIABLE and property.usage & PROPERTY_USAGE_EDITOR:
		return true
	else:
		return false
#Gives the Type as a String back.
static func getType(index):
	match index:
		1:	return "bool"
		2:	return "integer"
		3:	return "float"
		4:	return "string"
		5:	return "vector2"
		7:	return "vector3"