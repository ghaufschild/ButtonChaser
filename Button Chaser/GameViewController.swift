//  ViewController.swift
//  Button Chaser
//
//  Created by Garrett Haufschild on 9/1/15.
//  Copyright (c) 2015 Swag Productions. All rights reserved.
//
//  CGFloat(arc4random_uniform(255))

import UIKit
import iAd

class GameViewController: UIViewController {
    
    var screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
    var screenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    
    var scoreLabel: UILabel!
    var timerLabel: UILabel!
    var timeUpLabel: UILabel!
    var timeUpLabel2: UILabel!
    var highScoreLabel: UILabel!
    var scoreMultiplierLabel: UILabel!
    var multiplierBarLabel: UILabel!
    var currencyLabel: UILabel!
    var playingArea: UILabel!
    
    var button = UIButton(type: UIButtonType.System)
    var buttonTwo = UIButton(type: UIButtonType.System)
    var bonusButton = UIButton(type: UIButtonType.System)
    var resetButton = UIButton(type: UIButtonType.System)
    var mainScreenButton = UIButton(type: UIButtonType.System)
    
    var highScore = 0.0
    var score = 0.0
    var scoreMultiplier = 1.0
    var scoreTimeMax = 2.5
    var scoreTimeCur = 2.5
    var scoreTimer = NSTimer()
    var timer = NSTimer()
    var time: Double = 20.0
    var unpressed = true
    var backgroundHue: CGFloat = 0.0
    var buttonSide: CGFloat = 0.0
    var bonusButtonSide: CGFloat = 0.0
    var font20: CGFloat = 0
    var font25: CGFloat = 0
    var difficultyMultiplier = 1.0
    var buttonMultiplier = 1.0
    var settings = Settings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let settings = Settings.loadSaved()
        {
            self.settings = settings
        }
        else
        {
            let settings: Settings = Settings()
            settings.save()
            self.settings = settings
        }
        
        self.canDisplayBannerAds = true
        
        screenWidth = originalContentView.frame.width
        screenHeight = originalContentView.frame.height
        
        if(settings.difficulty == 0)                //Set up multiplier
        {
            difficultyMultiplier = 1
            buttonMultiplier = 1
        }
        if(settings.difficulty == 1)
        {
            difficultyMultiplier = 1.5
            buttonMultiplier = 1.25
        }
        if(settings.difficulty == 2)
        {
            difficultyMultiplier = 2
            buttonMultiplier = 1.5
        }
        if(settings.difficulty == 3)
        {
            difficultyMultiplier = 3
            buttonMultiplier = 2
        }
        
        font20 = screenWidth * 0.053
        font25 = screenWidth * 0.067
        
        highScore = settings.highScores[settings.difficulty]
        let buttonMuliplier = max(screenWidth * 0.84 / 4, screenHeight * 0.54/4)
        buttonSide = buttonMuliplier/CGFloat(buttonMultiplier)
        bonusButtonSide = buttonSide * 5/6
        
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////    LABELS     ///////////////////      LABELS      ///////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        //Playing Area Label
        playingArea = UILabel(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.3, screenWidth * 0.9, screenHeight * 0.59))
        playingArea.layer.backgroundColor = settings.determineBackground(settings.backgroundColor).CGColor
        playingArea.layer.borderColor = settings.determineTextColor(settings.buttonColor).CGColor
        playingArea.layer.borderWidth = screenWidth * 0.008
        view.addSubview(playingArea)
        
        //High Score Label
        highScoreLabel = UILabel(frame: CGRectMake(screenWidth * 0.2, screenHeight * 0.035, screenWidth * 0.65, screenHeight * 0.065))
        highScoreLabel.text = "High Score: \(highScore)"
        highScoreLabel.font = (UIFont(name: settings.font, size: font25))
        highScoreLabel.textAlignment = .Center
        highScoreLabel.adjustsFontSizeToFitWidth = true
        highScoreLabel.textColor = settings.determineTextColor(settings.buttonColor)
        highScoreLabel.layer.backgroundColor = settings.determineBackground(settings.backgroundColor).CGColor
        highScoreLabel.layer.borderColor = settings.determineTextColor(settings.buttonColor).CGColor
        highScoreLabel.layer.borderWidth = screenWidth * 0.008
        highScoreLabel.layer.cornerRadius = screenWidth * 0.05
        view.addSubview(highScoreLabel)
        
        //Score Label
        scoreLabel = UILabel(frame: CGRectMake(screenWidth * 0.08, screenHeight * 0.11, screenWidth * 0.38, screenHeight * 0.065))
        scoreLabel.text = "Score: 0"
        scoreLabel.font = (UIFont(name: settings.font, size: font20))
        scoreLabel.textAlignment = .Center
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.textColor = settings.determineTextColor(settings.buttonColor)
        scoreLabel.layer.backgroundColor = settings.determineBackground(settings.backgroundColor).CGColor
        scoreLabel.layer.borderColor = settings.determineTextColor(settings.buttonColor).CGColor
        scoreLabel.layer.borderWidth = screenWidth * 0.008
        scoreLabel.layer.cornerRadius = screenWidth * 0.05
        view.addSubview(scoreLabel)
        
        //Timer Label
        timerLabel = UILabel(frame: CGRectMake(screenWidth * 0.6, screenHeight * 0.11, screenWidth * 0.3, screenHeight * 0.065))
        timerLabel.text = "Time: 20.0"
        timerLabel.font = (UIFont(name: settings.font, size: font20))
        timerLabel.adjustsFontSizeToFitWidth = true
        timerLabel.textAlignment = .Center
        timerLabel.textColor = settings.determineTextColor(settings.buttonColor)
        timerLabel.layer.backgroundColor = settings.determineBackground(settings.backgroundColor).CGColor
        timerLabel.layer.borderColor = settings.determineTextColor(settings.buttonColor).CGColor
        timerLabel.layer.borderWidth = screenWidth * 0.008
        timerLabel.layer.cornerRadius = screenWidth * 0.05
        view.addSubview(timerLabel)
        
        //Time Up Label
        timeUpLabel = UILabel(frame: CGRectMake(screenWidth * 0.2, screenHeight * 0.50, screenWidth * 0.6, screenHeight * 0.06))
        timeUpLabel.text = "Time's LAME"
        timeUpLabel.font = (UIFont(name: settings.font, size: font20))
        timeUpLabel.textAlignment = .Center
        timeUpLabel.adjustsFontSizeToFitWidth = true
        timeUpLabel.textColor = settings.determineTextColor(settings.buttonColor)
        timeUpLabel.layer.backgroundColor = settings.determineBackground(settings.backgroundColor).CGColor
        timeUpLabel.layer.borderColor = settings.determineTextColor(settings.buttonColor).CGColor
        timeUpLabel.layer.borderWidth = screenWidth * 0.008
        timeUpLabel.layer.cornerRadius = screenWidth * 0.05
        
        //Time Up 2 Label
        timeUpLabel2 = UILabel(frame: CGRectMake(screenWidth * 0.2, screenHeight * 0.575, screenWidth * 0.6, screenHeight * 0.06))
        timeUpLabel2.text = "Your Score: Bad"
        timeUpLabel2.font = (UIFont(name: settings.font, size: font20))
        timeUpLabel2.textAlignment = .Center
        timeUpLabel2.adjustsFontSizeToFitWidth = true
        timeUpLabel2.textColor = settings.determineTextColor(settings.buttonColor)
        timeUpLabel2.layer.backgroundColor = settings.determineBackground(settings.backgroundColor).CGColor
        timeUpLabel2.layer.borderColor = settings.determineTextColor(settings.buttonColor).CGColor
        timeUpLabel2.layer.borderWidth = screenWidth * 0.008
        timeUpLabel2.layer.cornerRadius = screenWidth * 0.05
        
        //Currency Label
        currencyLabel = UILabel(frame: CGRectMake(screenWidth * 0.2, screenHeight * 0.65, screenWidth * 0.6, screenHeight * 0.06))
        currencyLabel.text = "Money: $\(settings.currency)"
        currencyLabel.font = (UIFont(name: settings.font, size: font20))
        currencyLabel.textAlignment = .Center
        currencyLabel.adjustsFontSizeToFitWidth = true
        currencyLabel.textColor = settings.determineTextColor(settings.buttonColor)
        currencyLabel.layer.backgroundColor = settings.determineBackground(settings.backgroundColor).CGColor
        currencyLabel.layer.borderColor = settings.determineTextColor(settings.buttonColor).CGColor
        currencyLabel.layer.borderWidth = screenWidth * 0.008
        currencyLabel.layer.cornerRadius = screenWidth * 0.05
        
        //Score Muliplier Label
        scoreMultiplierLabel = UILabel(frame: CGRectMake(screenWidth * 0.54, screenHeight * 0.18, screenWidth * 0.38, screenHeight * 0.07))
        scoreMultiplierLabel.text = "Multiplier: x1.0"
        scoreMultiplierLabel.font = (UIFont(name: settings.font, size: font20))
        scoreMultiplierLabel.textAlignment = .Center
        scoreMultiplierLabel.adjustsFontSizeToFitWidth = true
        scoreMultiplierLabel.textColor = settings.determineTextColor(settings.buttonColor)
        view.addSubview(scoreMultiplierLabel)
        
        
        //Multiplier Bar Label
        multiplierBarLabel = UILabel(frame: CGRectMake(screenWidth * 0.58, screenHeight * 0.25, screenWidth * 0.38, screenHeight * 0.01))
        multiplierBarLabel.backgroundColor = settings.determineTextColor(settings.buttonColor)
        view.addSubview(multiplierBarLabel)
        
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////    BUTTONS     /////////////////      BUTTONS      ///////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        //Button One
        button = UIButton(frame: CGRectMake(screenWidth * 0.3, screenHeight * 0.3, screenWidth * 0.4, screenHeight * 0.1))
        button.setTitle("", forState: UIControlState.Normal)
        button.addTarget(self, action: "changeLocationB1:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.layer.cornerRadius = 0.5 * buttonSide
        button.layer.borderWidth = buttonSide * 0.03
        button.layer.borderColor = UIColor.blackColor().CGColor
        if(settings.backgroundColor == 7)
        {
            button.layer.borderColor = UIColor.whiteColor().CGColor
        }
        
        //Button Two
        buttonTwo = UIButton(frame: CGRectMake(screenWidth * 0.3, screenHeight * 0.3, screenWidth * 0.4, screenHeight * 0.1))
        buttonTwo.setTitle("", forState: UIControlState.Normal)
        buttonTwo.addTarget(self, action: "changeLocationB2:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonTwo.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        buttonTwo.layer.cornerRadius = 0.5 * buttonSide
        buttonTwo.layer.borderWidth = buttonSide * 0.03
        buttonTwo.layer.borderColor = UIColor.blackColor().CGColor
        if(settings.backgroundColor == 7)
        {
            buttonTwo.layer.borderColor = UIColor.whiteColor().CGColor
        }
        
        //Special Button
        bonusButton = UIButton(frame: CGRectMake(screenWidth * 0.3, screenHeight * 0.3, screenWidth * 0.4, screenHeight * 0.1))
        bonusButton.setTitle("", forState: UIControlState.Normal)
        bonusButton.addTarget(self, action: "removeButton", forControlEvents: UIControlEvents.TouchUpInside)
        bonusButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal)
        bonusButton.layer.cornerRadius = 0.5 * bonusButtonSide
        bonusButton.layer.borderWidth = bonusButtonSide * 0.03
        bonusButton.layer.borderColor = UIColor.blackColor().CGColor
        if(settings.backgroundColor == 7)
        {
            bonusButton.layer.borderColor = UIColor.whiteColor().CGColor
        }
        
        //Replay Button
        resetButton.frame = CGRectMake(screenWidth * 0.05, screenHeight * 0.19, screenWidth * 0.4, screenWidth * 0.06)
        resetButton.setTitle("Play Again.", forState: UIControlState.Normal)
        resetButton.titleLabel!.font = UIFont(name: settings.font, size: font20)
        resetButton.addTarget(self, action: "reset", forControlEvents: UIControlEvents.TouchUpInside)
        resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        view.addSubview(resetButton)
        
        //Main Screen Button
        mainScreenButton = UIButton(frame: CGRectMake(screenWidth * 0.07, screenHeight * 0.24, screenWidth * 0.35, screenHeight * 0.05))
        mainScreenButton.setTitle("Settings", forState: UIControlState.Normal)
        mainScreenButton.titleLabel!.font = UIFont(name: settings.font, size: font20)
        mainScreenButton.addTarget(self, action: "returnToSettings", forControlEvents: UIControlEvents.TouchUpInside)
        mainScreenButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        view.addSubview(mainScreenButton)
        
        reset()                                         //Set game to correct settings
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////    BUTTON INTERACTIONS      /////////////////      BUTTON INTERACTIONS      ///////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func changeLocationB1(sender: AnyObject)            //make new button
    {
        let button = UIButton(type: UIButtonType.System)
        incrementScore(scoreMultiplier * Double(difficultyMultiplier))
        multiplierUpdate()
        if(unpressed)                                   //"Start" button clicked
        {
            scoreTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("scoreMultiplierUpdate"), userInfo: nil, repeats: true)
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
            unpressed = false
            scoreTimeMax = 2.5
            scoreTimeCur = scoreTimeMax
            scoreMultiplier = 1.0
            score = 0.0
            multiplierBarLabel.frame = CGRectMake(screenWidth * 0.54, screenHeight * 0.25, screenWidth * 0.38, screenHeight * 0.01)
            scoreMultiplierLabel.text = "Multiplier: x\(scoreMultiplier)"
        }
        self.button.removeFromSuperview()
        let but = findCoordinates("b1")
        button.backgroundColor = settings.determineTextColor(settings.buttonColor)
        button.frame = CGRectMake(but.0,but.1, buttonSide, buttonSide)
        button.addTarget(self, action: "changeLocationB1:", forControlEvents: UIControlEvents.TouchUpInside)
        button.layer.cornerRadius = 0.5 * buttonSide
        button.layer.borderWidth = buttonSide * 0.03
        button.layer.borderColor = UIColor.blackColor().CGColor
        if(settings.backgroundColor == 7)
        {
            button.layer.borderColor = UIColor.whiteColor().CGColor
        }
        self.view.addSubview(button)
        self.button = button
    }
    
    func changeLocationB2(sender: AnyObject)            //make new button
    {
        incrementScore(scoreMultiplier * Double(difficultyMultiplier))
        multiplierUpdate()
        let butTwo = findCoordinates("b2")
        buttonTwo.frame = CGRectMake(butTwo.0, butTwo.1, buttonSide, buttonSide)
        buttonTwo.backgroundColor = settings.determineTextColor(settings.buttonColor)
        self.view.addSubview(buttonTwo)
    }
    
    func addbonusButton()                               //add gold button
    {
        let coord = findCoordinates("b3")
        bonusButton.frame = CGRectMake(coord.0,coord.1, bonusButtonSide, bonusButtonSide)
        bonusButton.backgroundColor = UIColor(red: 255, green: 255, blue: 0, alpha: 1);
        bonusButton.setTitle("", forState: UIControlState.Normal)
        bonusButton.addTarget(self, action: "removeButton", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(bonusButton)
    }
    
    func removeButton()                                 //remove gold button and change score
    {
        incrementScore(3 * scoreMultiplier * Double(difficultyMultiplier))
        multiplierUpdate()
        bonusButton.removeFromSuperview()
    }
    
    func colors()
    {
        let bg = settings.determineBackground(settings.backgroundColor)
        var tc = settings.determineTextColor(settings.buttonColor)
        
        if((settings.buttonColor == settings.backgroundColor) && (!(settings.buttonColor == 0 && settings.backgroundColor == 0) && !(settings.buttonColor == 7 && settings.backgroundColor == 7)))          //Colors are the same
        {
            tc = UIColor.blackColor()
        }
        if(settings.buttonColor == 0 && settings.backgroundColor == 7)      //Both colors are black
        {
            tc = UIColor.whiteColor()
        }
        if(settings.buttonColor == 7 && settings.backgroundColor == 0)      //Both colors are white
        {
            tc = UIColor.blackColor()
        }
        
        originalContentView.backgroundColor = bg
        scoreLabel.layer.backgroundColor = bg.CGColor
        timerLabel.layer.backgroundColor = bg.CGColor
        timeUpLabel.layer.backgroundColor = bg.CGColor
        timeUpLabel2.layer.backgroundColor = bg.CGColor
        highScoreLabel.layer.backgroundColor = bg.CGColor
        currencyLabel.layer.backgroundColor = bg.CGColor
        playingArea.layer.backgroundColor = bg.CGColor
        
        scoreLabel.layer.borderColor = tc.CGColor
        timerLabel.layer.borderColor = tc.CGColor
        timeUpLabel.layer.borderColor = tc.CGColor
        timeUpLabel2.layer.borderColor = tc.CGColor
        highScoreLabel.layer.borderColor = tc.CGColor
        scoreMultiplierLabel.layer.borderColor = tc.CGColor
        currencyLabel.layer.borderColor = tc.CGColor
        playingArea.layer.borderColor = tc.CGColor
        
        scoreLabel.textColor = tc
        timerLabel.textColor = tc
        timeUpLabel.textColor = tc
        timeUpLabel2.textColor = tc
        highScoreLabel.textColor = tc
        scoreMultiplierLabel.textColor = tc
        currencyLabel.textColor = tc
        scoreMultiplierLabel.textColor = tc
        multiplierBarLabel.backgroundColor = tc
        
        button.backgroundColor = settings.determineTextColor(settings.buttonColor)
        
        if(settings.backgroundColor == 2)       //background is blue (change button colors)
        {
            mainScreenButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            resetButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////    TIME CHANGES      /////////////////      TIME CHANGES      ///////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func updateCounter()                                                    //Change time
    {
        time = (time - 0.1)                                                 //Decrement Time
        time = round(time * 10)/10
        timerLabel.text = "Time: \(time)"
        let timeCheck = round((time % 4) * 10)/10
        if(timeCheck == 1.0)                                                 //Every four seconds
        {
            addbonusButton()                                                //add gold button
        }
        if(timeCheck == 0.2)                                                 //after .8 seconds from button create time
        {
            bonusButton.removeFromSuperview()                               //remove gold button
        }
        if(time <= 0.0)                                                     //Game Over
        {
            settings.currency = settings.currency + Int(score)
            timer.invalidate()
            scoreTimer.invalidate()
            bonusButton.removeFromSuperview()
            button.removeFromSuperview()
            buttonTwo.removeFromSuperview()
            view.addSubview(timeUpLabel)
            view.addSubview(timeUpLabel2)
            view.addSubview(currencyLabel)
            timerLabel.text = "Time: 0.0"
            timeUpLabel.text = "Time's Up!"
            timeUpLabel2.text = "Your Score is: \(score)"
            currencyLabel.text = "Money: $\(settings.currency)"
            if(score > highScore)
            {
                highScore = score
                highScore = round(highScore * 10)/10
                highScoreLabel.text = "High Score: \(highScore)"
            }
            unpressed = true
            save()
        }
    }
    
    func scoreMultiplierUpdate()                    //Run every 100th of a second - timer
    {
        scoreTimeCur = scoreTimeCur - 0.01
        if(scoreTimeCur <= 0)
        {
            scoreMultiplier = scoreMultiplier - 0.1
            if(scoreMultiplier < 1.0)
            {
                scoreMultiplier = 1.0
            }
            scoreTimeMax = scoreTimeMax + 0.1
            if(scoreTimeMax > 2.5)
            {
                scoreTimeMax = 2.5
            }
            scoreTimeCur = scoreTimeMax
        }
        multiplierBarLabel.frame = CGRectMake(screenWidth * 0.54, screenHeight * 0.25, screenWidth * 0.38 * CGFloat(scoreTimeCur/scoreTimeMax), screenHeight * 0.01)
        scoreMultiplierLabel.text = "Multiplier: x\(scoreMultiplier)"
    }
    
    func multiplierUpdate()                         //When button is hit
    {
        scoreMultiplier = scoreMultiplier + 0.1
        if(scoreMultiplier > 3.0)
        {
            scoreMultiplier = 3.0
        }
        scoreTimeMax = scoreTimeMax - 0.1
        if(scoreTimeMax < 0.15)
        {
            scoreTimeMax = 0.15
        }
        scoreTimeCur = scoreTimeMax
        multiplierBarLabel.frame = CGRectMake(screenWidth * 0.54, screenHeight * 0.25, screenWidth * 0.38 * CGFloat(scoreTimeCur/scoreTimeMax), screenHeight * 0.01)
        scoreMultiplierLabel.text = "Multiplier: x\(scoreMultiplier)"
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////    SCORE CHANGES      /////////////////      SCORE CHANGES      //////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func incrementScore(number: Double)
    {
        score = score + number
        if(score < 0)
        {
            score = 0
        }
        score = round(score * 10)/10
        scoreLabel.text = "Score: \(score)"
        colors()
    }
    
    @IBAction func decrementScore(sender: AnyObject)
    {
        if(!unpressed)
        {
            scoreTimeMax = 2.5
            scoreTimeCur = scoreTimeMax
            scoreMultiplier = 1.0
            incrementScore(-1)
            multiplierBarLabel.frame = CGRectMake(screenWidth * 0.54, screenHeight * 0.25, screenWidth * 0.38 * CGFloat(scoreTimeCur/scoreTimeMax), screenHeight * 0.01)
            scoreMultiplierLabel.text = "Multiplier: x\(scoreMultiplier)"
        }
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////    BUTTON PLACEMENT      /////////////////      BUTTON PLACEMENT      /////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func findCoordinates(bName: String) -> (CGFloat, CGFloat)                   //Checks if coordinates do not intefere with other buttons
    {
        var final: CGPoint = generateCoordinates()
        while(checkOverlap(bName, bSpec: final))
        {
            final = generateCoordinates()
        }
        return (final.x, final.y)
    }
    
    func checkOverlap(bName: String, bSpec: CGPoint) -> (Bool)                  //Check Overlap with other buttons, return true if not overlapped
    {
        if(bName == "b1")                                                       //If new button is first button
        {
            let buttonSpec: CGPoint = bSpec
            let buttonTwoSpec: CGPoint = CGPoint(x: buttonTwo.frame.minX, y: buttonTwo.frame.minY)
            let bonusButtonSpec: CGPoint = CGPoint(x: bonusButton.frame.minX, y: bonusButton.frame.minY)
            if((time % 4 >= 1.1 || time % 4 <= 0.1))                            //check if bonus button is active
            {
                return (checkTheOver(buttonSpec, bSpec2: buttonTwoSpec))        //return true if overlapped
            }
            else
            {
                return (checkTheOver(buttonSpec, bSpec2: buttonTwoSpec) || checkTheOver(buttonSpec, bSpec2: bonusButtonSpec))   //return true if overlapped
            }
        }
        else if(bName == "b2")                                                  //If new button is second button
        {
            let buttonSpec: CGPoint = CGPoint(x: button.frame.minX, y: button.frame.minY)
            let buttonTwoSpec: CGPoint = bSpec
            let bonusButtonSpec: CGPoint = CGPoint(x: bonusButton.frame.minX, y: bonusButton.frame.minY)
            if((time % 4 >= 1.1 || time % 4 <= 0.1))                            //check if bonus button is active
            {
                return (checkTheOver(buttonSpec, bSpec2: buttonTwoSpec))
            }
            else
            {
                return (checkTheOver(buttonSpec, bSpec2: buttonTwoSpec) || checkTheOver(buttonTwoSpec, bSpec2: bonusButtonSpec))
            }
        }
        else                                                                    //If new button is extra button
        {
            let buttonSpec: CGPoint = CGPoint(x: button.frame.minX, y: button.frame.minY)
            let buttonTwoSpec: CGPoint = CGPoint(x: buttonTwo.frame.minX, y: buttonTwo.frame.minY)
            let bonusButtonSpec: CGPoint = bSpec
            return (checkTheOver(bonusButtonSpec, bSpec2: buttonSpec) || checkTheOver(bonusButtonSpec, bSpec2: buttonTwoSpec))
        }
    }
    
    //check if y values are within one another
    //check if x values are within one another
    //if y value is above y's of other
    //OR
    //if x value is between x's of other
    
    
    func checkTheOver(bSpec1: CGPoint, bSpec2: CGPoint) -> Bool                 //Returns true if within certain distance of eachother
    {
        let dist: CGFloat = buttonSide/2 + (screenWidth * 0.01)
        if(((bSpec1.y + dist >= bSpec2.y - dist && bSpec1.y + dist <= bSpec2.y + dist) || (bSpec1.y - dist >= bSpec2.y - dist && bSpec1.y - dist <= bSpec2.y + dist)) && ((bSpec1.x + dist >= bSpec2.x - dist && bSpec1.x + dist <= bSpec2.x + dist) || (bSpec1.x - dist >= bSpec2.x - dist && bSpec1.x - dist <= bSpec2.x + dist)))
        {
            return true
        }
        return false
    }
    
    func generateCoordinates() -> (CGPoint){                                    //Generate random coordinates
        let specX = arc4random_uniform(UInt32((screenWidth * 0.86) - buttonSide)) + UInt32(screenWidth * 0.07)
        let specY = arc4random_uniform(UInt32((screenHeight * 0.55) - buttonSide)) + UInt32(screenHeight * 0.32)
        let specXValue : CGFloat = CGFloat(specX)
        let specYValue : CGFloat = CGFloat(specY)
        return CGPoint(x: specXValue, y: specYValue)
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////    NEW GAME     /////////////////      NEW GAME     //////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func reset()
    {
        bonusButton.removeFromSuperview()
        button.removeFromSuperview()
        buttonTwo.removeFromSuperview()
        timer.invalidate()
        scoreTimer.invalidate()
        score = 0
        timer = NSTimer()
        scoreTimer = NSTimer()
        time = 20.0
        unpressed = true
        backgroundHue = 0
        timerLabel.text = "Time: \(time)"
        button.frame = CGRectMake(screenWidth/2 - buttonSide/2, screenHeight/2, buttonSide, buttonSide)
        button.addTarget(self, action: "changeLocationB2:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        view.backgroundColor = settings.determineBackground(settings.backgroundColor)
        scoreLabel.text = "Score: 0"
        multiplierBarLabel.frame = CGRectMake(screenWidth * 0.54, screenHeight * 0.25, screenWidth * 0.38, screenHeight * 0.01)
        scoreMultiplier = 1.0
        scoreMultiplierLabel.text = "Multiplier: x\(scoreMultiplier)"
        timeUpLabel.removeFromSuperview()
        timeUpLabel2.removeFromSuperview()
        currencyLabel.removeFromSuperview()
        colors()
    }
    
    func save()
    {
        settings.highScores[settings.difficulty] = highScore
        settings.save()
    }
    
    func returnToSettings()
    {
        scoreTimer.invalidate()
        timer.invalidate()
        performSegueWithIdentifier("toSettingsFromGame", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let dvc = segue.destinationViewController as! SettingsViewController
        dvc.settings = self.settings
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////    AD STUFF     /////////////////      AD STUFF     //////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewWillAppear(animated: Bool) {
        // Advert has been dismissed. Resume paused activities
        if(!unpressed)
        {
            time += 0.3
            scoreTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("scoreMultiplierUpdate"), userInfo: nil, repeats: true)
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        // View is about to be obscured by an advert.
        // Pause activities if necessary
        timer.invalidate()
        scoreTimer.invalidate()
    }
}
