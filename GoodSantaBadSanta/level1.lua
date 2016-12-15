-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()


--include score.lua
--to use later
local score_objectcreator=require("score")
local score_object=score_objectcreator.new("10")
	local score_count=0

-- local test_creator=require("test")
-- local test_object;

--------------------------------------------

local power_visbility_table={}
local power_stages_table={}





---Pause
local paused=false


-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

local function removeObject(obj)
 if (obj~=nil) then 
 	obj:removeSelf() 
 end 
end

local function removeSanta(bs)
	--print("bs"..tostring(bs))
	if bs.removeSelf then
		--transition.fadeOut( bs, { time=500 } )
			
		transition.to( bs, { time=1000, alpha=0, xScale=(0.01), yScale=(0.01),onCancel=removeObject} )


		-- bs:removeSelf()
		-- print("Inside removeSanta");
		-- bs=nil
	end

end



local function transition_3()
  -- powerText.text = "powerText_3"
   transition.to(powerText,{time=50,xScale=1,yScale=1, onComplete=function (obj)
   obj.isVisible=false end})

end
local function transition_2()
   --powerText.text = "powerText_2"
   transition.to(powerText,{time=50,xScale=1.1,yScale=1.1,onComplete=transition_3})
end

local function score_transition_3()
  -- powerText.text = "powerText_3"
   transition.to(gift_score,{time=50,xScale=1,yScale=1})
end
local function score_transition_2()
   --powerText.text = "powerText_2"
   transition.to(gift_score,{time=50,xScale=1.1,yScale=1.1,onComplete=score_transition_3})
end

local function goToMenu()
	-- body
	composer.gotoScene("menu",{ effect="crossFade", time=500 })

end

local function decreasePower( )
	-- body
	if (power_full.isVisible) then
		power_full.isVisible=false
		power_sevenfive.isVisible=true
		power_visbility_table[1]="false"
		power_visbility_table[2]="true"
		powerText.text="Watch it!"
		transition.to(powerText,{time=100,xScale=1.2,yScale=1.2,onComplete=transition_2})


	elseif (power_sevenfive.isVisible) then
		power_sevenfive.isVisible=false
		power_half.isVisible=true
		power_visbility_table[2]="false"
		power_visbility_table[3]="true"
		powerText.isVisible=true
		powerText.text="Careful!"
		transition.to(powerText,{time=100,xScale=1.2,yScale=1.2,onComplete=transition_2})	

	elseif(power_half.isVisible) then
		power_half.isVisible=false
		power_twofive.isVisible=true
		power_visbility_table[3]="false"
		power_visbility_table[4]="true"
		powerText.isVisible=true
		powerText.text="Caution!"
		transition.to(powerText,{time=100,xScale=1.2,yScale=1.2,onComplete=transition_2})

	else
		power_twofive.isVisible=false
		power_zerop.isVisible=true
		power_visbility_table[4]="false"
		power_visbility_table[5]="true"
		--end the game----
		-- composer.removeScene("level1",true)
		if santa_table~=nil then
			for i = #santa_table,1,-1 do
			 local removeObj =    table.remove(santa_table,i)
			 if removeObj~=nil then
			 	print("here in santa table")
					display.remove(removeObj)
					removeObj=nil
				end
			end
		end
		mthird_timer= timer.performWithDelay(400,goToMenu(),1)
		
	end
end


local function callremoveSanta(bs)
	removeSanta(bs)

end
local function moveGift(obj )
	-- body
	transition.moveTo(obj,{x=0,y=0,time=500})


end
local function destroygift()
	-- body
	gift:removeSelf()
end

local function onBSTouch( event )
    if ( event.phase == "began" ) then
        print( "Touch event began on: " .. event.target.id )
        if event.target.id=="good" then
       
        	score_count=score_count+10
        	print("Score"..score_count..tostring(score_object))
        	local x_gift= event.target.x
        	local y_gift=event.target.y

        	local gift=display.newImageRect( "res/test_gift.png", 50,  50 )
        	
		
			gift.x, gift.y = x_gift, y_gift

			transition.fadeIn(gift,{time=100,onCancel=function(obj) obj:removeSelf() end})
			transition.scaleTo(gift,{ xScale=0.001, yScale=0.01,time=500,onCancel=function(obj) obj:removeSelf() end})
			transition.to( gift, { time=600, x=halfW-125,y=display.contentHeight/2-220, onComplete= function(obj) obj:removeSelf() end,onCancel=function(obj) obj:removeSelf() end} )
			transition.to(gift_score,{time=100,xScale=1.2,yScale=1.2,onComplete=score_transition_2})

			--transition.moveTo(gift,{x=0,y=0,time=700})
			--gift:removeSelf()
        	
        	myText.text=""..score_count
        	event.target:removeSelf()
    	else
    		score_count=score_count-10
        	myText.text=""..score_count
        	decreasePower()
    		event.target:removeSelf()
    	end
    elseif ( event.phase == "ended" ) then
        print( "Touch event ended on: " .. event.target.id )
    end
    return true
end

local function showSantaRandomly()
		--print("Inside showsanta");
		santa_table={}
		-- possible values : 
		--width variation : 
		--(screenW/2,screenH/2),(screenW/2.5,screenH/2),(screenW/3,screenH/2),(screenW/3.5,screenH/2),
		--(screenW/4,screenH/2),(screenW/4.5,screenH/2)
		--(screenW/5,screenH/2) diff 6 between divisor is needed  w/=1.1 and 11
		--w=11,5,3.3,2.5,2,1.65,1.42,1.23,1.1
		--local sceneGroup= self.view
		local noOfSantas=math.random(1,10)

		for i=1,noOfSantas do
				
			local yCoord = math.random(-screenH/2.5,screenH/2+10)
			local sceneGroup=scene.view

			local goodOrBadSantaTable = {

			[1]="santa_head_test.png",
			[2]="grinch_santa_test.png"


			}

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
	    	local yCoordTable = {
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

	    	local randomSanta=math.random(1,2)
	 
	    	local xCoord=math.random(1,9)	    		    	
	    	local yCoord=math.random(1,9)

	
			 bs= display.newImageRect(goodOrBadSantaTable[randomSanta],20,20)
			bs.x,bs.y=screenW/xCoordTable[xCoord],screenH/yCoordTable[yCoord]
			transition.scaleBy( bs, {  xScale=(1), yScale=(1),time=500,onComplete=callremoveSanta,onCancel=function(obj) obj:removeSelf() end} )
			
			if randomSanta==1 then
				bs.id="good"	
			else
				bs.id="bad"
			end
			bs:addEventListener( "touch", onBSTouch )	

			--transition.fadeIn( bs, { time=500, onComplete=callremoveSanta } )
		
			--sceneGroup:insert( bs)
			table.insert(santa_table,bs)

			--print(i)
		end
		

		


end

local function spawnSanta(event)
	
  	showSantaRandomly() 

end

---paused so remove powerbar
local function hideOrShowPowerBar(  )
	-- body
	print("Paused "..tostring(paused))
	if paused==true then
		--power_full.isVisible=false
		print("I'm here!")
		for i=1,#power_stages_table do
			--print("I'm here!"..tostring(i))
			if power_visbility_table[i]=="true" then
				print("i "..tostring(i).." power_stage "..tostring(power_stages_table[i]))
				power_stages_table[i].isVisible=false
			end
		end


	else
		for i=1,#power_stages_table  do
			print("I'm here!"..tostring(i))
			if power_visbility_table[i]=="true" then
				power_stages_table[i].isVisible=true
			end
		end




	end



end
--pause method
function pause(event)
	print("Paused : "..tostring (paused))
  -- if event.phase == "began" then
        if paused == false then
        	physics.pause()
			-- star:removeEventListener( "preCollision", star )
			-- star:removeEventListener( "postCollision", star )
			-- Runtime:removeEventListener("touch", touchScreen)
	 	-- 	Runtime:removeEventListener("collision", onCollision)
	 		transition.cancel()
			timer.pause(mfirst_timer)
			myText.isVisible=false
			gift_score.isVisible=false
			display.setStatusBar( display.DefaultStatusBar )
			paused = true
			hideOrShowPowerBar()
			local options = {
		    isModal = true,
		    effect = "fade",
		    time = 400,
		    params = {
		        sampleVar = "my sample variable"
		    }
		}

		-- By some method (a pause button, for example), show the overlay
		composer.showOverlay( "bonus_round", options )
             
        elseif paused == true then
            physics.start()
   --          star:addEventListener( "preCollision", star )
			-- star:addEventListener( "postCollision", star )
			-- Runtime:addEventListener("touch", touchScreen)
	 	-- 	Runtime:addEventListener("collision", onCollision)
	 		--movePlayer(player)
	 		timer.resume(mfirst_timer)
	 		PauseBtn.isVisible=true
			myText.isVisible=true
			gift_score.isVisible=true
			display.setStatusBar( display.HiddenStatusBar )
			
            paused = false
            hideOrShowPowerBar()
        end
 -- end
end

function scene:create( event )

	-- Called when the scene's view does not exist
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- create a grey rectangle as the backdrop
	local background = display.newImageRect( "test_mainbgthird.PNG", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0

	 --------score text-------------------------------------------------------------
	 myText = display.newText(" "..score_count,halfW-100,20,"Apple Chancery",22)
	 myText:setFillColor(1,1,0)
	 gift_score= display.newImageRect("res/test_gift.png",35,35)
	 gift_score.anchorX=0
	 gift_score.anchorY=0
	 gift_score.x,gift_score.y=halfW-150,display.contentHeight/2-238

	 --myText:setFillColor( 0,0.392157,0 )

	 -- local  powerBar = display.newRect(210, 6, 24, 9)
  --   powerBar.strokeWidth = 1
  --   powerBar:setStrokeColor(1,1,1) 
  --   powerBar:setFillColor(234,183,30)    
     ------------------------------------------------------------------------------- 
     --powerbar creation------------------------------------------------------------
     placePower={halfW+30,65}
	 power_full = display.newImageRect( "res/powerbar.png", 200, 200 )
	 power_sevenfive= display.newImageRect( "res/powerbar_75p.png", 200, 200 )
	 power_half= display.newImageRect( "res/powerbar_50p.png", 200, 200 )
	 power_twofive= display.newImageRect( "res/powerbar_25p2.png", 200, 200 )
	 power_zerop= display.newImageRect( "res/powerbar_zerop.png", 200, 200 )
	 power_full.x,power_full.y=placePower[1],placePower[2]
  	 power_sevenfive.x,power_sevenfive.y=placePower[1],placePower[2]
   	 power_half.x,power_half.y=placePower[1],placePower[2]
     power_twofive.x,power_twofive.y=placePower[1],placePower[2]
     power_zerop.x,power_zerop.y=placePower[1],placePower[2]
     power_full.isVisible=true
     power_sevenfive.isVisible=false
	 power_half.isVisible=false
	 power_twofive.isVisible=false
	 power_zerop.isVisible=false

	 power_stages_table[1]=power_full
	 power_stages_table[2]=power_sevenfive
	 power_stages_table[3]=power_half
	 power_stages_table[4]=power_twofive
	 power_stages_table[5]=power_zerop
	
	 --put in power_visbility_table
	 power_visbility_table[1]="true"	
	 -----------------------------------------------------------------------------

	 powerText = display.newText("",halfW+22,display.contentHeight/2-200,native.systemFont,18)
	 powerText:setFillColor(1, 0, 0)





	 --test pause

	 displayPause = display.newText( "Pause", 160, 240, "Times New Roman", 60 )
	 displayPause.isVisible=false



	 PauseBtn = display.newImageRect("res/pause.png",display.contentWidth*0.3,45)



	-- width=display.contentWidth*0.3, height=45,
	PauseBtn.x = display.contentWidth*0.9
	PauseBtn.y = display.contentHeight*1.01
	--PauseBtn.isVisible=false --remove this later
	PauseBtn:addEventListener( "tap", pause)



	 -----------------------------------------------------------------------------

	 -------timer text-----------

	-- timerText= display.newText(,halfW+55,display.contentHeight/2-200,native.s)















	 -------------------------------------
	-- 	 local rect=display.newRect(100,300,20,70)
 -- rect:setFillColor(100,100,200,200)
	-- -- make a crate (off-screen), position it, and rotate slightly
	-- local crate = display.newImageRect( "crate.png", 90, 90 )
	-- crate.x, crate.y = 160, -100
	-- crate.rotation = 15
	
	-- -- add physics to the crate
	-- physics.addBody( crate, { density=1.0, friction=0.3, bounce=0.3 } )
	
	-- -- create a grass object and add physics (with custom shape)
	-- local grass = display.newImageRect( "grass.png", screenW, 82 )
	-- grass.anchorX = 0
	-- grass.anchorY = 1
	-- grass.x, grass.y = 0, display.contentHeight
	
	-- -- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	-- local grassShape = { -halfW,-34, halfW,-34, halfW,34, -halfW,34 }
	-- physics.addBody( grass, "static", { friction=0.3, shape=grassShape } )
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert(power_full)
	sceneGroup:insert(power_twofive)
	sceneGroup:insert(power_half)
	sceneGroup:insert(power_sevenfive)
	sceneGroup:insert(power_zerop)
	sceneGroup:insert(powerText)
	sceneGroup:insert( myText )
	sceneGroup:insert(gift_score)
	sceneGroup:insert(PauseBtn)
	sceneGroup:insert(displayPause)

	--test_object=test_creator.new("Yai")

	
	----------call Santa!!--------------------
	mfirst_timer= timer.performWithDelay(800,spawnSanta,0)	
	--timer.params={mSceneG=sceneGroup}
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

		


		physics.start()
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
		print("Scene hidden")
		--timer.cancel(mfirst_timer)
	--	timer.cancel(msecond_timer)
		-- if santa_table~=nil then
		-- 	for i = #santa_table,1,-1 do
		-- 	 local removeObj =    table.remove(santa_table,i)
		-- 	 if removeObj~=nil then
		-- 			display.remove(removeObj)
		-- 			removeObj=nil
		-- 		end
		-- 	end
		-- end
		timer.cancel(mfirst_timer)
		transition.cancel()
		
		--timer.cancel(msecond_timer)
		physics.stop()
		
		-- for i=0,#santa_table do
		-- 	local removeObj = table.remove(recs, randNumber)
		-- 	-- if santa_table[i]~=nil then
		-- 	-- 	santa_table[i]:removeSelf()
		-- 	-- 	santa_table[i]=nil
		-- 	-- end
		-- 	if removeObj~=nil then
		-- 		removeObj:removeSelf()
		-- 		removeObj=nil
		-- 	end
		-- end
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	--score_object.writeScore(score_count)
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene