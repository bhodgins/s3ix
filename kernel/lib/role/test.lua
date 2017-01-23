local class = require('lib/vendor/middleclass/middleclass')
require('kernel/lib/role/queue')

local test = class('testing')
test:include(queue)

test:put(10)
local a = test:next()
print(a)