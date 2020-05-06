extends Control

class TableEntry:
	var pName = ""
	var map = ""
	var mode = ""
	var time = ""
	var count = ""
	var score = ""

	func _init(pName,map,mode,time,count,score):
		self.pName = pName
		self.map = map
		self.mode = mode
		self.time = time
		self.count = count
		self.score = score

const Rows = 5
const ScoreQuery = "http://fullmetalai.school4games.net/LeaderBoard/getScore.php"

func _ready():
	startRequest()

func startRequest():
	
	if $EntryContainer.entries.size() > 0:
		for i in range($EntryContainer.entries.size()):
			var entry = $EntryContainer.entries.pop_back()
			entry.queue_free()
	
	$HTTPRequest.request(ScoreQuery)

func onHTTPRequestRequestCompleted(result, response_code, headers, body):
	if result == $HTTPRequest.RESULT_SUCCESS:
		handleRequest(body)
		

func handleRequest(body):
	
	var table = body.get_string_from_utf8()
	
	var lines = table.split("\n",false)
	
	for i in lines.size():
		var row = lines[i].split(",")
		if row.size() >= Rows:
			createEntry(i,row)

func createEntry(idx,row):
	
	var entry = TableEntry.new(row[0],row[1],row[2],row[3],row[4],row[5])
	
	if $EntryContainer != null:
		$EntryContainer.addEntry(idx+1 ,entry)