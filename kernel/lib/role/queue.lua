-- Provides queue-like behavior to a class:
Queue = { buffer = {} }

function queue.put(self, ...)
  for _, v in ipairs({...}) do
  	table.insert(self.buffer, 1, v)
	end
end

function queue.next(self)
	return table.remove(self.buffer)
end
