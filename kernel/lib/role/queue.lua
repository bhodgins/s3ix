-- Provides queue-like behavior to a class:
queue = { buffer = {} }

function queue.put(...)
  for _, v in ipairs(arg) do
	  table.insert(queue.buffer, 1, v)
	end
end

function queue.next()
	return table.remove(queue.buffer)
end
