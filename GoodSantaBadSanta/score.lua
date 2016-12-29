local score={}

local score_mt={__index=score}

---------------------------------------------
---private functions
--read file
local function readFromFile( filename)
	-- body
	local contents
	--local path = system.pathForFile( "myfile"..paramsToBringBack..".txt", system.DocumentsDirectory )
	print("filename "..tostring(filename))
	local path = system.pathForFile( filename, system.DocumentsDirectory )
	-- Open the file handle
	local file, errorString = io.open( path, "r" )

	if not file then
	    -- Error occurred; output the cause
	    print( "File read error: " .. errorString )
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

function writeToFile(filename,score_recv)
	local saveData = score_recv
	local fname=filename

	-- Path for the file to write
	--local path = system.pathForFile( "myfile"..paramsToBringBack..".txt", system.DocumentsDirectory )

	local path = system.pathForFile( filename, system.DocumentsDirectory )

    --print( "File error: "  )
	-- Open the file handle
	local file, errorString = io.open( path, "w" )

	if not file then
	    -- Error occurred; output the cause
	    print( "File write error: " .. errorString )
	else
	    -- Write data to file
	    print( "File error: 1" )

	    file:write( score_recv )
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
function score:setScore(filename,score_recv)
	local ftp=filename
	  print( "File error set : "  )

	writeToFile(ftp,score_recv)

end


function score:getScore(filename)
	local readfile=filename
	print("Read file "..tostring(readfile))
	return readFromFile(readfile)

end
function score:hello()
	print("heello")
end


----------------------------------------------
return score


