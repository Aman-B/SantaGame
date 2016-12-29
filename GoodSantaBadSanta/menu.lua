-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"
local physics = require "physics"
physics.start();
--------------------------------------------
local snow_table = 
        {

            [1]="res/snowball.png",
            [2]="res/snowflake.png"

            
        }

-- forward declarations and other locals
local playBtn

--key handling function
	local function onKeyEvent( event )
		local phase = event.phase
		   local keyName = event.keyName
		   print( event.phase, event.keyName )
		   currScene= composer.getSceneName("current")
		   print("Current : "..currScene)
		 
		   if ( ("back" == keyName and phase == "down") or ("back" == keyName and phase == "up") ) then
			   --    if(back_count==2) then
						 --native.requestExit()	
					--timer.performWithDelay(5000,removeListener())
				  -- end	
				 -- back_count=back_count+1	  
		   return true
	   		end
	   return false	-- body
	end

-- on instructBtnRelease----
local function onInstructBtnRelease()
	--TODO : make this

		local options = {
		    isModal = true,
		    effect = "fade",
		    time = 400,
		    params = {
		        sampleVar = "my sample variable"
		    }
		}
	composer.showOverlay("instructions",options)

end	


-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	
	-- go to level1.lua scene
	sceneName= composer.getScene("level1")

	if sceneName~=nil then
		print("Scene exists, removing it.")
		composer.removeScene("level1")
	end



	composer.gotoScene( "level1", "fade", 500 )
	
	return true	-- indicates successful touch
end

local function startSnowFall()
	-- body
	local xCoordTable = {
                [1] = 8,
                [2] = 7,
                [3] = 3.3,
                [4] = 2.5,
                [5] = 2,
                [6] = 1.65,
                [7] = 1.42,
                [8] = 1.23,
                [9] = 1.1,
            }
    local xCoord=math.random(1,9)

    local randomSnow=math.random(1,display.contentWidth)
    local randomnum=math.random(1,2)
  --  print("Inside gifts!")
 --  	local snowball = display.newCircle( display.contentWidth/xCoordTable[xCoord], -10, 2 )
	-- snowball:setFillColor( 1 )
	if randomnum>1 then
    local snowball= display.newImageRect("res/snowflake.png",10,10)
     snowball.x= randomSnow
     snowball.y= 0
    transition.to(snowball, 
    {
        time=10000, 
        x=display.contentWidth/xCoordTable[xCoord], 
        y=display.contentHeight+100, 
        tag="Snowball",
        onCancel=function(obj) obj:removeSelf() end
    })
	
	else
		local snowball = display.newCircle( randomSnow, 0, 1.5 )
		snowball:setFillColor( 1 )
		transition.to(snowball, 
    {
        time=10000, 
        x=randomSnow, 
        y=display.contentHeight+100, 
        tag="Snowball",
        onCancel=function(obj) obj:removeSelf() end
    })
    -- physics.addBody( snowball,{ density=-1,friction=1} )
    -- snowball.gravityScale=0.2
    end	
    
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "test_mainbgsecond.png", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImageRect( "game_titletwo.png", 264, 50 )
	titleLogo.x = display.contentWidth * 0.5
	titleLogo.y = 100


	----yay! snow!---------
 	timer.performWithDelay(100,startSnowFall,0) 
	
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		label="Play Now",
		--labelColor = { default={255}, over={128} },
		
		width=154, height=40,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = display.contentWidth*0.5
	playBtn.y = display.contentHeight - 155

	instruct = widget.newButton{
		label="How to play?",
		--labelColor = { default={255}, over={128} },
		
		width=154, height=40,
		onRelease = onInstructBtnRelease	-- event listener function
	}
	instruct.x = display.contentWidth*0.5
	instruct.y = display.contentHeight - 105
	
	
	-- local santa_ride = display.newImageRect( "finalmovewelcome_test.png", 500, 1000 )
	-- santa_ride.anchorX = display.contentWidth/2
	-- santa_ride.anchorY = display.contentHeight/2
	-- santa_ride.x, santa_ride.y = 0, display.contentHeight/2



	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( playBtn )
	sceneGroup:insert( instruct )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
			Runtime:addEventListener("key",onKeyEvent)
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	package.loaded[physics] = nil
	physics = nil
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene