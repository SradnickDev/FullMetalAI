extends Navigation

class ThreadPool:
	var pool = []
	var instance = null
	var method = ""
	var param = null
	
	func _init(threadCount,instance,method,param):
		self.instance = instance
		self.method = method
		self.param = param
		
		for i in threadCount:
			var newThread = Thread.new()
			pool.append(newThread)
			newThread.start(instance,method,param)
	
	func append():
		var newThread = Thread.new()
		pool.append(newThread)
		newThread.start(instance,method,param)
		
	func size():
		return pool.size()

class Request:
	
	var start = Vector3(0,0,0)
	var end = Vector3(0,0,0)
	var agent = null
	
	func _init(agent,start,end):
		self.agent = agent
		self.start = start
		self.end = end

class Result:
	
	var agent = null
	var path = null
	
	func _init(agent,path):
		self.agent = weakref(agent)
		self.path = path
	
	func setPath():
		if agent.get_ref():
			agent.get_ref().setPath(path)

export(int) var threadCount = 3
export(int) var maxThreadCount = 10

var threadPool
var requests = []
const MaxRequests = 100

var mutex
var semaphore

func _ready():
	mutex = Mutex.new()
	semaphore = Semaphore.new()
	threadPool = ThreadPool.new(threadCount,self,"threadStart",0)

func addRequest(agent,start,end):
	mutex.lock()
	
	print("Add Request",requests.size())
	var newRequest = Request.new(agent,start,end)
	requests.push_back(newRequest)
	
	
	if requests.size() > MaxRequests:
		print("Too much Requests.")
	
	mutex.unlock()
	semaphore.post()

func threadStart(param):
	while true:
		semaphore.wait()
		#print("Semaphore Err:",t)
		var request = getRequest()
		var result = evaluateRequest(request)
		call_deferred("onNewResult",result)

func getRequest():
	mutex.lock()
	
	print("requests pop_front",requests.size())
	var request = requests.pop_front()
	
	mutex.unlock()
	
	return request

func evaluateRequest(request):
	
	var path = get_simple_path(request.start,request.end,true)
	
	var retVal = Result.new(request.agent,path)
	
	return retVal

func onNewResult(result):
	result.setPath()
