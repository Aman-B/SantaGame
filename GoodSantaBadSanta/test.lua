local test = {}
local test_mt = { __index = test }	-- metatable

-------------------------------------------------
-- PRIVATE FUNCTIONS
-------------------------------------------------

-- local function getDogYears( realYears )	-- local; only visible in this module
-- 	return realYears * 7
-- end

-------------------------------------------------
-- PUBLIC FUNCTIONS
-------------------------------------------------

function test.new( valueOfScore)	-- constructor
		
	local newTest = {
		value =  valueOfScore or 2
	}
	
	return setmetatable( newTest, test_mt )
end

-------------------------------------------------

function test:rollOver()
	print( self.value .. " rolled over." )
end

-------------------------------------------------



-------------------------------------------------

return test