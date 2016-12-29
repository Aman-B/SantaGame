local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
-- include Corona's "widget" library
local widget = require "widget"


local score_objectcreator=require("score")
local score_object=score_objectcreator.new("10")
local score_object_two=score_objectcreator.new("10")
    local score_count=0

-- for share module
local myClass = require("share");

-- local function onPlayBtnRelease(event)
--     --To play the sound effect
--     print("Print something!")
-- end
--share button
local function onShareBtnReleased (event)
    --To play the sound effect
        --sfxr.play(sfxr.buttonSound,{channel=3})
    myClass.onShareButtonReleased(event)
end

local function onRateButtonReleased(event)
        local options =
        {
         
           supportedAndroidStores = { "google" }
        }
        native.showPopup( "appStore", options )
        print("Rating!")


end



--home button
local function showHome(event)
    --To play the sound effect
    --    sfxr.play(sfxr.buttonSound,{channel=3})
    
    --composer.removeScene("gae")
    composer.removeScene("level1")
    --remove banner ads
    --coronaAds.hide(bannerPlacement)
    composer.gotoScene("menu")
    end



--replay button handler
local function onPlayBtnRelease(event)
    --To play the sound effect
    
       -- sfxr.play(sfxr.buttonSound,{channel=3})

    composer.removeScene("level1")
    
    local options = 
    {
    effect = "fade",
    time = 500
    -- params = 
    --     {
    --         level=paramsToBringBack
            
    --     }
    }
    --remove banner ads
    --coronaAds.hide(bannerPlacement)
    composer.removeScene("level1")
    composer.removeScene("gameOver")
    composer.gotoScene( "level1",options)
    
    return true -- indicates successful touch
end



--compare with highscore and save
local function compareWithHighScoreAndSave( score)
    -- body
    local saved_score= score_object:getScore("scorefile.txt")

    if saved_score== nil then
        score_object:setScore("scorefile.txt",score)
        --print("HighScore 1 "..saved_score)
        txt_game.text="        Score :"
    else
        if tonumber(saved_score)<tonumber(score) then
            print("Highscore 2 "..score)
            txt_game.text="       Score : HighScore!!"
            score_object:setScore("scorefile.txt",score)
        end
    end
end



-- create()
function scene:create( event )  

    local sceneGroup = self.view
    local params= event.params
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local got_score=score_object_two:getScore("timegift.txt")
    if(got_score==nil) then
        got_score=0
    end
    ---backdrop
    local background = display.newImageRect( "test_mainbgthird.PNG", display.contentWidth, display.contentHeight )
    background.anchorX = 0
    background.anchorY = 0
    background.x, background.y = 0, 0

    txt_game= display.newText( "Score: ", display.contentWidth*0.5, display.contentHeight-400, native.systemFontBold, 20 )
    txt_game:setFillColor( 0.941, 0.976, 0)

    local gift_score= display.newImageRect("res/test_gift.png",35,35)
     gift_score.anchorX=0
     gift_score.anchorY=0
     gift_score.x,gift_score.y=display.contentWidth/2-60,display.contentHeight-370


     local txt_giftscore= display.newText( "Score: ", gift_score.x+60, display.contentHeight-350, native.systemFontBold, 20 )
    txt_giftscore:setFillColor( 0.941, 0.976, 0)
    txt_giftscore.text="= "..params.scoreText

    scoreToSend=params.scoreText
    compareWithHighScoreAndSave(params.scoreText)

    local txt_time= display.newText( "= ", display.contentWidth*0.5, display.contentHeight-280, native.systemFontBold, 20 )
    txt_time:setFillColor( 0.941, 0.976, 0)   
    txt_time.text="  * "..got_score.." = "
   
    local surprise_giftscore= display.newImageRect("res/giftscore_test.png",35,35)
    surprise_giftscore.anchorX=0
    surprise_giftscore.anchorY=0
    surprise_giftscore.x,surprise_giftscore.y=txt_time.x-60,display.contentHeight-300

    timesanta_num=tostring(math.floor(got_score/5))
    print("ts : "..timesanta_num)
    local txt_timesanta= display.newText( " ", txt_time.x+60, display.contentHeight-280, native.systemFontBold, 20 )
    txt_timesanta:setFillColor( 0.941, 0.976, 0)   
    txt_timesanta.text=" "..timesanta_num.." * "

    local time_santa= display.newImageRect("res/time_santa.png",20,25)
     time_santa.anchorX=0
     time_santa.anchorY=0
     time_santa.x,time_santa.y=txt_timesanta.x+30,display.contentHeight-292


    local ReplayBtn = widget.newButton {
        fontSize="20",
        font="Bold",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 }  },
        defaultFile="res/replay.png",
        overFile="res/replay_tapped.png",
        width=display.contentWidth*0.08, height=25,
        onRelease = onPlayBtnRelease    -- event listener function
    }


    ReplayBtn.x = display.contentWidth*0.3
    ReplayBtn.y = display.contentHeight - 200
    
--share button
    local shareButton = widget.newButton{

        fontSize="20",
        font="Bold",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 }  },
        defaultFile="res/share.PNG",
        overFile="res/share_tapped.png",
        width=display.contentWidth*0.09, height=30,
        id = "share",    
        onRelease = onShareBtnReleased -- event listener function
    }
    shareButton.x = display.contentWidth*0.5
    shareButton.y = display.contentHeight -200





    --home button
    local HomeBtn = widget.newButton {
        
        fontSize="20",
        font="Bold",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 }  },
        defaultFile="res/home.png",
        overFile="res/home_tapped.png",
        width=display.contentWidth*0.09, height=30,
        onRelease = showHome    -- event listener function
    }




    

    HomeBtn.x = display.contentWidth*0.7
    HomeBtn.y = display.contentHeight - 200

    
    ---rate button
    txt_rate= display.newText( "Rate the app?", 160, display.contentHeight-110, "Times New Roman", 20 )
    txt_rate:addEventListener("tap",onRateButtonReleased)
    txt_rate.isVisible=false

    if(math.random(0,10)<5)then
        txt_rate.isVisible=true
    end
    
   -- print("Score : "..tostring(score_object:getScore("timegift.txt"))..tostring(system.pathForFile( "timegift.txt", system.DocumentsDirectory )))

    sceneGroup:insert(background)
    sceneGroup:insert(txt_game)
    sceneGroup:insert(ReplayBtn)
    sceneGroup:insert(shareButton)
    sceneGroup:insert(HomeBtn)
    sceneGroup:insert(txt_rate)
    sceneGroup:insert( time_santa )
    sceneGroup:insert(txt_giftscore)
    sceneGroup:insert(txt_time)
    sceneGroup:insert(txt_timesanta)
    sceneGroup:insert(gift_score)
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
        print("timesanta_num before"..timesanta_num)
        timesanta_num=timesanta_num+score_object:getScore("timesanta.txt")
        print("timesanta_num after"..timesanta_num)
        score_object:setScore("timesanta.txt",timesanta_num)
        print(score_object:getScore("timesanta.txt"))
        score_object_two:setScore("timegift.txt",0)

        

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