centerX, centerY = display.contentCenterX, display.contentCenterY
--All the text
home = "Forced from your homeland, you take a ship to the Principality of Constantioch.\nThere you found little opportunity to move up the social hierarchy\nas you wasted away your days on the streets living in squalor.\nTired of this, you enlisted into the Constantian army, where you\nquickly rose up in the ranks and demonstrated your worth. \nThe small principality, seeking new wealth, sends out their army to \nconquer the surrounding states. You are its general."
gull = "To the east, there lies the city-state of Gull.  Lying as a gate between the west \nand the east, Gull developed itself as the regional trade hub \nbetween the western christendom kingdoms and the Sultanates of the east.\nThe Principality, seeking wealth and resources, came upon the city..."

--Your Attributes/Resources
day = 0
food = 30
army = 10000
i=2
local morale = {
	"very high",
	"high",
	"medium",
	"low",
	"very \nlow"
	}
score = (army/1000) + (food/10) - i
--Gull's Attributes
gullFood = 40
gullArmy = 7500
j=3
local gullMorale = {
	"very high",
	"high",
	"med",
	"low",
	"very \nlow"
	}
Gullscore = (gullArmy/1000) + (food/10) - j
--Music
local soundID = audio.loadSound("Theme.mp3")
audio.play (soundID)

--Title Screen
local title = display.newText("Siege Simulator", centerX, centerY-485, "Old English Text MT",100)
display.newRect(centerX,centerY-425,2000,4)
local display1 = display.newImage("Backgrounds/Siege1.jpg", centerX, centerY)
local startButton = display.newText("Begin your adventure", centerX, centerY+400, "Bodoni MT",70)

function siege(e)
	if e.phase == "began" then
		local function recalcScore()
			score = (army/1000) + (food/10) - i
			Gullscore =  (gullArmy/1000) + (food/10) - j
			yourDisplay.text ="food: "..food.."\nmen: "..army.."\nmorale: "..morale[i].."\nscore: "..score
			gullDisplay.text ="food: "..gullFood.."\nmen: "..gullArmy.."\nmorale: "..gullMorale[j].."\nscore: "..Gullscore
		end

		local function newDay()
			day = day + 1
			food = food - 1
			gullFood = gullFood - 1
			dayDisplay.text = "Day "..day
			raidChance = math.random(1,3)
			if raidChance == 1 then
				lostMen = math.random(100,500)
				army = army - lostMen
				gullLostMen = math.random(30,150)
				gullArmy = gullArmy - gullLostMen
				theText1.text = "                         The city sends out a raiding party.\nThey kill "..lostMen.." of your men. Among the dead you find "..gullLostMen.." attackers"
			else 
				theText1.text = "The city tries to smuggle supplies into the city"
				gullFood = gullFood + math.random(0,2)
			end
			recalcScore()
		end
	--WHEN SCAVENGE IS PRESSED THIS HAPPENS:
		local function moreFood(event)
			randomFood  = math.random(0,3)
			food = food + randomFood
			newDay()
				if randomFood == 0 then
					theText.text = "You send out men to scavenge for food, but they come back empty"
				else 
					theText.text = "You send out men to scavenge for food \n They come back with "..randomFood.." days worth of food"
				end
		end
	--WHEN RECRUIT MEN IS PRESSED THIS HAPPENS:
		local function moreMen(event)
			randomMen = math.random(100,350)
			army = army + randomMen
			newDay()
			theText.text = "You recruit mercenaries.\n"..randomMen.." men are recruited."
		end
	--WHEN YOU STORM THE CASTLE IS PRESSED THIS HAPPENS
		local function storm(event)
			day = day + 1
			dayDisplay.text = "Day "..day
			recalcScore()
			if score > 2*Gullscore then 
				theText.text = "Your troops storm the castle, taking out all that oppose them\nThe Constantian flag is hoisted above the city in triumphant victory"
				theText1.text = "YOU WIN"
			else
			stormLostMen = math.random (400,1000)
			stormGullLostMen = math.random(300,500)
			army = army - stormLostMen
			gullArmy = gullArmy - stormGullLostMen
			theText.text = "Your troops storm the castle, but are overwhelmed and surrounded.\n                  They retreat, wounded, battered, and defeated"
			theText1.text = "You lose "..stormLostMen.." men, while the defenders lost ".. stormGullLostMen.." men"
			end
		end
	--INTRO TO HUD
	theText.text = "You reach the gates of Gull.\n Setting up your base, you decide to..."
	theText.fontSize = 70
	theText.y = centerY
	dayDisplay = display.newText("Day "..day, centerX-800, centerY-485,"Bodoni MT",70)
	display.newText ("Constantinian Army", centerX-640, centerY-370, "Bodoni MT", 70)
	yourDisplay = display.newText("food: "..food.."\nmen: "..army.."\nmorale: "..morale[i].."\nscore: "..score, centerX-750,centerY-200,"Bodoni MT",70)
	theText1 = display.newText("",centerX,centerY+100,"Bodoni MT", 50)
	display.newText("City-State of Gull", centerX+690, centerY-370, "Bodoni MT",70)
	gullDisplay = display.newText("food: "..gullFood.."\nmen: "..gullArmy.."\nmorale: "..gullMorale[j].."\nscore: "..Gullscore, centerX+750,centerY-200,"Bodoni MT",70)
	siegeStart:removeSelf()

	local option1 = display.newText("Scavenge for food", centerX-600, centerY+400, "Bodoni MT",70)
	option1: addEventListener("tap", moreFood)
	local option2 = display.newText("Storm the city!\n(requires score x2)", centerX, centerY+400, "Bodoni MT",70)
	option2: addEventListener("tap", storm)
	local option3 = display.newText("Hire Mercenaries", centerX+600, centerY+400, "Bodoni MT",70)
	option3: addEventListener("tap", moreMen)
	end
end
--Title Screen
function start()
	 function begin(e)--Sets up next page
		if e.phase== "began" then
			display1:removeSelf()
			theText = display.newText(home,centerX,centerY-200,"Bodoni MT", 50)
			startButton:removeSelf()
		end

		function continue(e)
			if e.phase == "began" then
			theText.text = gull
			continueButton:removeSelf()
			siegeStart = display.newText("BEGIN THE SIEGE!", centerX, centerY+400, "Bodoni MT",70)
			siegeStart:addEventListener("touch", siege)
			end
		end

		continueButton = display.newText("Continue", centerX, centerY+400, "Bodoni MT",70)
		continueButton: addEventListener("touch", continue)

	end
startButton:addEventListener("touch", begin)
end
start()