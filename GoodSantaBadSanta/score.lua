local score={}

local score_mt={__index=score}

---------------------------------------------
---private functions
--read file
local function readFromFile( )
	-- body
	local contents
	--local path = system.pathForFile( "myfile"..paramsToBringBack..".txt", system.DocumentsDirectory )
	local path = system.pathForFile( "scorefile.txt", system.DocumentsDirectory )
	-- Open the file handle
	local file, errorString = io.open( path, "r" )

	if not file then
	    -- Error occurred; output the cause
	    print( "File error: " .. errorString )
	else
	    -- Read data from file
	    contents = file:read( "*a" )
	    -- Output the file contents
	    print( "Contents of " .. path .. "\n" .. contents )
	    -- Close the file handle
	    io.close( file )
	end

	file = nil
	return contents

end



--write to file

function writeToFile(score_recv)
	local saveData = score_recv

	-- Path for the file to write
	--local path = system.pathForFile( "myfile"..paramsToBringBack..".txt", system.DocumentsDirectory )

	local path = system.pathForFile( "scorefile.txt", system.DocumentsDirectory )

	-- Open the file handle
	local file, errorString = io.open( path, "w" )

	if not file then
	    -- Error occurred; output the cause
	    print( "File error: " .. errorString )
	else
	    -- Write data to file
	    file:write( saveData )
	    -- Close the file handle
	    io.close( file )
	end

	file = nil


end







---------------------------------------------
--Public functions --------------------------



function score.new(valueOfScore)

	local newScore={
	value=valueOfScore
}
	return setmetatable(newScore,score_mt)



end

---write to file
function score:setScore(score_recv)
	writeToFile(score_recv)

end


function score:getScore()
	return readFromFile()

end
function score:hello()
	print("heello")
end


----------------------------------------------
return score


