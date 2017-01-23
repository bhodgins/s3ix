function create_queue()
	local queue  = { buffer = {} }
 
	function queue.put(...)
	  for _, v in ipairs(arg) do
		  table.insert(queue.buffer, 1, v)
		end
	end
 
	function queue.next()
	  return table.remove(queue.buffer)
	end
 
	return queue
end
 
function spawn_service_manager()
	local service_manager = {}
	local services        = {}
 
	local function create_service(chunk)
		local service = {}

		-- TODO 
 
		return service
	end
 
	function service_manager.kldload(chunk)
		local service = create_service(chunk)
		table.insert(services, service)
		service() -- Initialize the service
	end
 
	return service_manager
end
 
function spawn_vfs()
	local vfs         = {}
	local handles     = {}
	local mountpoints = {}
	local filesystems = {}
 
	function vfs.open()  end
	function vfs.close() end
	function vfs.read()  end
	function vfs.write() end
 
	return vfs
end
 
function spawn_scheduler(init)
	local scheduler = {}
	local processes = {}
 
	-- Load a process into memory:
	local function create_process(chunk)
  		local process  = create_queue()
  		local watchers = {}
  		local co       = nil
 
  		function process.next()
    		for _, msg in ipairs(process.buffer) do
      			for _, watcher in ipairs(watchers) do
      				-- Handle watcher
      			end
      			table.remove(queue.buffer) -- deueue-like operation
    		end
    		coroutine.resume(co)
    		return coroutine.status(co)
  		end
 
    	-- Load process:
    	co = coroutine.create(chunk)
    	return process
	end
 
	function scheduler.spawn(chunk)
		local proc = create_process(chunk)
		table.insert(processes, proc)
	end
 
	function scheduler.run()
		for index, process in ipairs(processes) do
			local status = process.next()
			if status == 'dead' then
				process = nil
				table.remove(processes, index)
				print("Process quit")
			end
		end
		-- return scheduler.run()
	end
 
	-- Bootstrap the init system:
	scheduler.spawn(init)
	return scheduler
end
 
function _main()
	local scheduler = spawn_scheduler(load(""))
	local service   = spawn_service_manager()
	local vfs       = spawn_vfs()
 
	scheduler.run()
end
 
_main()

--[[
% ifconfig
olan0: flags: UP, RUNNING, SIMPLEX, UNICAST, BROADCAST metric 0 mtu 53
	options: MSGPACK
	hw 9783a6b3-430c-4199-8a6b-d8cbfe228334
	gert internal 457-6643-4
	nnr link local 0:c4::d8cbfe228334
	nnr link global 9001:0:f4c::d8cbfe228334
	media: OCR (OCranet Relay)
	status: active
onet0: flags: UP, RUNNING, SIMPLEX, UNICAST metric 0 mtu 53
	options: MSGPACK, INET_GATEWAY, NNR_SUBNET
	hw 098b0763-ef22-492d-805f-057d1881abff
	gert external 457-6643
	nnr link local 0:7f::057d1881abff
	nnr link global 9001:0:deadbeef:2:057d1881abff
	inet gateway ocr.9600-baud.net
	media: OCR (OCranet Relay)
	status: active
lo0: flags: UP, RNNING, UNICAST, LOOPBACK metric 0 mtu 8192
	nnr link loopback 1::1
%
--]]
