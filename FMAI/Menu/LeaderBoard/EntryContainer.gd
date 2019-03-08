extends ScrollContainer

export(PackedScene) var entry
export(bool) var setFullEntry = true
export(float) var scrollSpeed = 2

var entries = []
var vScrollBar

func _ready():
	vScrollBar = get_child(2)

func addEntry(rank,tableEntry):
	if setFullEntry == false:
		var mapName = String(MetaData.getSimpleMeta(MetaData.Map))
		mapName = mapName.replace(" ","_")

		if tableEntry.map != mapName:
			return
	
	if $Entries/WaitLabel.visible:
		$Entries/WaitLabel.visible = false
	
	var entry = createEntry()
	$Entries.add_child(entry)
	
	entry.setRank(rank)
	entry.setName(tableEntry.pName)
	
	if setFullEntry:
		entry.setMap(tableEntry.map)
	
	entry.setMod(tableEntry.mode)
	entry.setTime(tableEntry.time)
	entry.setKillCount(tableEntry.count)
	entry.setScore(tableEntry.score)
	
	
	entries.append(entry)

func createEntry():
	var newEntry = entry.instance()
	return newEntry

func _process(delta):
	scroll_vertical += Input.get_joy_axis(0,JOY_AXIS_3) * scrollSpeed