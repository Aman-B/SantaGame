local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
--key handling function
    local function onKeyEvent( event )
        local phase = event.phase
           local keyName = event.keyName
           print( event.phase, event.keyName )
           currScene= composer.getSceneName("current")
           print("Current : "..currScene)
         
           if ( ("back" == keyName and phase == "down") or ("back" == keyName and phase == "up") ) then
              
              -- if ( currScene == "menu" ) then
              --    native.requestExit()
              -- else
                    if ( currScene == "menu" ) then                    
                    print("going to menua")
                    --remove banner ads
                    --coronaAds.hide(bannerPlacement)
                    print("going to menu")
                    composer.hideOverlay( "fade", 400 ) 
                    --return true     
                 return true
                  --end
              end
           
            end
       return false -- body
    end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen


    local background = display.newImageRect( "test_mainbgthird.PNG", display.contentWidth, display.contentHeight )
    background.anchorX = 0
    background.anchorY = 0
    background.x, background.y = 0, 0

    local  txt_game= display.newText( "Instructions: ", display.contentWidth*0.5, display.contentHeight-450, native.systemFontBold, 20 )
    

   local gift_score= display.newImageRect("santa_head_test.png",15,15)
     gift_score.anchorX=0
     gift_score.anchorY=0
     gift_score.x,gift_score.y=display.contentWidth/2-120,display.contentHeight-420

   local giftscore_txt= display.newText("Tap ",gift_score.x-20,gift_score.y+10,native.systemFont,15)
   local giftscore_txt2=display.newText("to collect max gifts",gift_score.x+90,gift_score.y+10,native.systemFont,15)

    local gift_score2= display.newImageRect("res/test_gift.png",15,15)
     gift_score2.anchorX=0
     gift_score2.anchorY=0
     gift_score2.x,gift_score2.y=gift_score.x+160,gift_score.y+4



    local giftscore_txt12= display.newText("Tapping",gift_score.x-10,gift_score.y+50,native.systemFont,15)
   local giftscore_txt13=display.newText("will cause life loss and gift loss (-10)",gift_score.x+160,gift_score.y+50,native.systemFont,15)

    local gift_score5= display.newImageRect("grinch_santa_test.png",15,15)
     gift_score5.anchorX=0
     gift_score5.anchorY=0
     gift_score5.x,gift_score5.y=gift_score.x+18,gift_score.y+45


    local gift_score3= display.newImageRect("res/supergood_santa.png",15,15)
     gift_score3.anchorX=0
     gift_score3.anchorY=0
     gift_score3.x,gift_score3.y=display.contentWidth/2-120,display.contentHeight-340




   local giftscore_txt3= display.newText("Tap ",gift_score3.x-20,gift_score3.y+10,native.systemFont,15)
   local giftscore_txt4=display.newText(" to increase time by 2 sec",gift_score3.x+110,gift_score3.y+10,native.systemFont,15)

   local gift_score4= display.newImageRect("res/surprise_santa_new.png",15,15)
     gift_score4.anchorX=0
     gift_score4.anchorY=0
     gift_score4.x,gift_score4.y=display.contentWidth/2-120,display.contentHeight-300

   local giftscore_txt5= display.newText("Tap ",gift_score4.x-20,gift_score4.y+10,native.systemFont,15)
   local giftscore_txt6=display.newText("  to start a bonus round!",gift_score4.x+100,gift_score4.y+10,native.systemFont,15)

    

   local giftscore_txt7= display.newText("In bonus round,",display.contentWidth*0.2,display.contentHeight-250,native.systemFont,15)
   local giftscore_txt8=display.newText("collect max gifts:",giftscore_txt7.x+110,giftscore_txt7.y,native.systemFont,15)

    local giftscore_txt9= display.newText("Gifts collected in bonus round,",display.contentWidth*0.35,display.contentHeight-220,native.systemFont,15)
   --local giftscore_txt10=display.newText("collect max gifts:",giftscore_txt7.x+110,giftscore_txt9.y,native.systemFont,15)


    local surprise_giftscore= display.newImageRect("res/giftscore_test.png",15,15)
    surprise_giftscore.anchorX=0
    surprise_giftscore.anchorY=0
    surprise_giftscore.x,surprise_giftscore.y=giftscore_txt9.x+20,display.contentHeight-200

     local txt_timesanta= display.newText( " * 5 = 1 *", giftscore_txt9.x+60, display.contentHeight-190, native.systemFontBold, 15 )
    txt_timesanta:setFillColor( 0.941, 0.976, 0)   
    --txt_timesanta.text=" "..timesanta_num.." * "

    local time_santa= display.newImageRect("res/time_santa.png",15,15)
     time_santa.anchorX=0
     time_santa.anchorY=0
     time_santa.x,time_santa.y=txt_timesanta.x+30,display.contentHeight-200

     local time_santa2= display.newImageRect("res/time_santa.png",15,15)
     time_santa2.anchorX=0
     time_santa2.anchorY=0
     time_santa2.x,time_santa2.y=txt_timesanta.x-160,display.contentHeight-170

     local giftscore_txt10= display.newText(" (the time santa)will be saved.",display.contentWidth*0.4,display.contentHeight-160,native.systemFont,15)


     local giftscore_txt11= display.newText("Tap on top right time santa icon during game, \nto gain 10 seconds.",display.contentWidth*0.40,display.contentHeight-120,native.systemFont,12)

    Runtime:addEventListener("key",onKeyEvent)

    sceneGroup:insert(background)
    sceneGroup:insert(txt_game)
    sceneGroup:insert(gift_score)
    sceneGroup:insert(gift_score2)
    sceneGroup:insert(gift_score3)
    sceneGroup:insert(gift_score4)
    sceneGroup:insert(gift_score5)
    sceneGroup:insert(giftscore_txt)
    sceneGroup:insert(giftscore_txt2)
    sceneGroup:insert(giftscore_txt3)
    sceneGroup:insert(giftscore_txt4)
    sceneGroup:insert(giftscore_txt5)
    sceneGroup:insert(giftscore_txt6)
    sceneGroup:insert(giftscore_txt7)
    sceneGroup:insert(giftscore_txt8)
    sceneGroup:insert(giftscore_txt9)
    sceneGroup:insert(giftscore_txt10)
    sceneGroup:insert(giftscore_txt11)
    sceneGroup:insert(giftscore_txt12)
    sceneGroup:insert(giftscore_txt13)
    sceneGroup:insert(time_santa)
    sceneGroup:insert(time_santa2)
    sceneGroup:insert(txt_timesanta)
    sceneGroup:insert(surprise_giftscore)
    


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

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
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