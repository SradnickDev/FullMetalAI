extends Control

signal requestCompleted
export(NodePath) var closeFocus

var url = "http://fullmetalai.school4games.net/LeaderBoard/addScore.php?"

var config = ConfigFile.new()

func _ready():
	$SubmittedName.loadName()

func onSubmitButtonPressed():
	$HTTPRequest.cancel_request()
	postQuery()
	
	$SubmittedName.saveName()
	$Submit.visible = false
	$SubmittedName.editable = false
	get_node(closeFocus).grab_focus()

#?name=Oliver&map=BestMapEver&mod=BattleRoyal&time=10:00&killcount=alle&score=alle 
func postQuery():
	var headers = ["Content-Type: text/plain charset=utf-8"]
	
	var pName = str("name=",$SubmittedName.text,"&")
	var map = str("map=",MetaData.getSimpleMeta(MetaData.Map),"&")
	var mod = str("modi=",MetaData.getSimpleMeta(MetaData.Mode),"&")
	var time = str("time=",MetaData.getSimpleMeta(MetaData.LifeTime),"&")
	var killcount = str("killcount=",MetaData.getSimpleMeta(MetaData.Killed),"&")
	var score = str("score=",MetaData.getSimpleMeta(MetaData.Score))
	
	var query = str(pName,map,mod,time,killcount,score)
	query = query.replace(" ","_")
	
	$HTTPRequest.request(str(url,query),headers,true,HTTPClient.METHOD_POST)

func onHTTPRequestCompleted(result, response_code, headers, body):
	if response_code == 200:
		$SubmittedName.text = "Saved"
		emit_signal("requestCompleted")
	else:
		$SubmittedName.text = "Something went wrong.."