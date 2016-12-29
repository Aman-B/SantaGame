local composer = require( "composer" )

local scene = composer.newScene()
local physics = require "physics"
physics.start();

-- include Corona's "widget" library
local widget = require "widget"

-- physics.pause()

--include score.lua
--to use later
local score_objectcreator=require("score")
local score_object=score_objectcreator.new("10")
    local score_count=0

 local surprise_gift_score

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local gift_table = 
        {

            [1]="res/giftone.png",
            [2]="res/gifttwo.png"

            
        }

local function surprise_gift_score_transition_3()
  -- powerText.text = "powerText_3"
   transition.to(surprise_gift_score,{time=50,xScale=1,yScale=1})
end
local function surprise_gift_score_transition_2()
   --powerText.text = "powerText_2"
   --print("In transition")
   transition.to(surprise_gift_score,{time=50,xScale=1.1,yScale=1.1,onComplete=surprise_gift_score_transition_3})
end


local function onGiftTouch( event )

    score_count=score_count+1
    bonus_score_text.text="  "..score_count
    event.target.isVisible=false
    local x_plusT= event.target.x
    local y_plusT=event.target.y
    local plusT= display.newText("+1",display.contentWidth/2-100,20,native.systemFont,32)
    plusT:setFillColor( 0.941, 0.976, 0)
            
        
    plusT.x, plusT.y = x_plusT, y_plusT

    transition.fadeIn(plusT,{time=100,onCancel=function(obj) obj:removeSelf() end})
    transition.scaleTo(plusT,{ xScale=0.001, yScale=0.01,time=500,onCancel=function(obj) obj:removeSelf() end})
    transition.to( plusT, { time=600, x=display.contentWidth/2-100,y=display.contentHeight/2-220, onComplete= function(obj) obj:removeSelf() end,onCancel=function(obj) obj:removeSelf() end} )
    transition.to(surprise_gift_score,{time=100,xScale=1.5,yScale=1.5,onComplete=surprise_gift_score_transition_2})

end
function startGiftRain()
    
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

    local randomGift=math.random(1,2)
  --  print("Inside gifts!")
    gift_obj= display.newImageRect(gift_table[randomGift],30,30)
    gift_obj.x=display.contentWidth/xCoordTable[xCoord]
    gift_obj.y=-10
    transition.to(gift_obj, 
    {
        time=3000, 
        x=display.contentWidth/xCoordTable[xCoord], 
        y=display.contentHeight+100, 
        tag="myGift",
        onCancel=function(obj) obj:removeSelf() end,
        onComplete=function(obj) obj:removeSelf() end

    })

    gift_obj:addEventListener( "touch", onGiftTouch )   

end        

local function pause()
    print("In score "..score_count)
    
    score_object:setScore("timegift.txt",score_count)
    composer.hideOverlay( "fade", 400 ) 
    -- timer.cancel(mGiftTimer)
    -- transition.cancel()
        
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()



function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    ---backdrop
    local background = display.newImageRect( "test_mainbgthird.PNG", display.contentWidth, display.contentHeight )
    background.anchorX = 0
    background.anchorY = 0
    background.x, background.y = 0, 0


    surprise_gift_score= display.newImageRect("res/giftscore_test.png",35,35)
    surprise_gift_score.anchorX=0
    surprise_gift_score.anchorY=0
    surprise_gift_score.x,surprise_gift_score.y=display.contentWidth/2-150,display.contentHeight/2-238
    
    bonus_score_text = display.newText(" : 0",display.contentWidth/2-100,20,native.systemFont,18)
    bonus_score_text:setFillColor( 0.941, 0.976, 0)
    
    score_count=score_object:getScore("timegift.txt")
    if score_count== nil then
        score_count=0
    end
    bonus_score_text.text=score_count

    local  bonus_level_text = display.newText("BONUS LEVEL",display.contentWidth/2+20,20,native.systemFontBold,12)

     bonus_level_text:setFillColor(1, 0, 0)


     --local myRect = display.newRect( -10, -10, 20, 20 )

    -- Add a body to the rectangle
   -- physics.addBody( myRect, "dynamic" )

    -- Set gravity scale



    --  PauseBtn = display.newImageRect("res/pause.png",display.contentWidth*0.3,45)



    -- -- width=display.contentWidth*0.3, height=45,
    -- PauseBtn.x = display.contentWidth*0.9
    -- PauseBtn.y = display.contentHeight*1.01
    -- --PauseBtn.isVisible=false --remove this later
    -- PauseBtn:addEventListener( "tap", pause)
    mGiftTimer= timer.performWithDelay(100,startGiftRain,100)  
   timer.performWithDelay(10000,pause,1) 

    sceneGroup:insert(background)
    sceneGroup:insert(bonus_score_text)
    sceneGroup:insert(bonus_level_text)
    sceneGroup:insert(surprise_gift_score)



end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  

    if ( phase == "will" ) then
        timer.cancel(mGiftTimer)
        transition.cancel()
        print("In hide")
        parent:resumeGame()
        

        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        timer.cancel(mGiftTimer)
        transition.cancel()
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene