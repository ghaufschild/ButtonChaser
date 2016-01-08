//
//  SettingsViewController.swift
//  Button Chaser
//
//  Created by Garrett Haufschild on 11/23/15.
//  Copyright © 2015 Swag Productions. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
    let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    
    var settings = Settings()
    
    var highScoreLabel: UILabel!
    var highScoreLabel2: UILabel!
    var difficultyLabel: UILabel!
    var buttonStyleLabel: UILabel!
    var currencyLabel: UILabel!
    var currencyLabel2: UILabel!
    
    var difficultyButton: UIButton!
    var buttonStyleButton: UIButton!
    var resetSingleScore: UIButton!
    var resetAllScores: UIButton!
    var mainScreenButton: UIButton!
    
    var devButton: UIButton!
    
    var difficultyArray: Array<String> = ["Easy", "Medium", "Hard", "Insane"]
    var font25: CGFloat = 0
    var font20: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canDisplayBannerAds = true
        
        font25 = screenWidth * 0.067
        font20 = screenWidth * 0.053

        view.backgroundColor = settings.textBackground
        
        //High Score Label 1
        highScoreLabel = UILabel(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.075, screenWidth * 0.43, screenHeight * 0.06))
        highScoreLabel.text = "High Score:"
        highScoreLabel.font = (UIFont(name: settings.font, size: font25))
        highScoreLabel.adjustsFontSizeToFitWidth = true
        highScoreLabel.textAlignment = .Center
        highScoreLabel.textColor = settings.textColor
        highScoreLabel.layer.backgroundColor = settings.textBackground.CGColor
        highScoreLabel.layer.borderColor = settings.textColor.CGColor
        highScoreLabel.layer.borderWidth = screenWidth * 0.006
        highScoreLabel.layer.cornerRadius = screenWidth * 0.04
        view.addSubview(highScoreLabel)
        
        //High Score Label 2
        highScoreLabel2 = UILabel(frame: CGRectMake(screenWidth * 0.6, screenHeight * 0.075, screenWidth * 0.25, screenHeight * 0.06))
        highScoreLabel2.font = (UIFont(name: settings.font, size: font25))
        highScoreLabel2.textColor = settings.textColor
        highScoreLabel2.textAlignment = .Center
        view.addSubview(highScoreLabel2)
        
        //Difficulty Level
        difficultyLabel = UILabel(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.275, screenWidth * 0.55, screenHeight * 0.07))
        difficultyLabel.text = "Difficulty Level:"
        difficultyLabel.font = (UIFont(name: settings.font, size: font25))
        difficultyLabel.adjustsFontSizeToFitWidth = true
        difficultyLabel.textColor = settings.textColor
        difficultyLabel.textAlignment = .Center
        difficultyLabel.layer.backgroundColor = settings.textBackground.CGColor
        difficultyLabel.layer.borderColor = settings.textColor.CGColor
        difficultyLabel.layer.borderWidth = screenWidth * 0.006
        difficultyLabel.layer.cornerRadius = screenWidth * 0.04
        view.addSubview(difficultyLabel)
        
        //Difficulty Button
        difficultyButton = UIButton(frame: CGRectMake(screenWidth * 0.6, screenHeight * 0.275, screenWidth * 0.35, screenHeight * 0.07))
        difficultyButton.setTitle("\(difficultyArray[settings.difficulty])", forState: UIControlState.Normal)
        difficultyButton.titleLabel!.font = UIFont(name: settings.font, size: font25)
        difficultyButton.addTarget(self, action: "changeDifficulty", forControlEvents: UIControlEvents.TouchUpInside)
        difficultyButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        view.addSubview(difficultyButton)
        
        //Button Style Label
        buttonStyleLabel = UILabel(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.45, screenWidth * 0.48, screenHeight * 0.07))
        buttonStyleLabel.text = "Button Style:"
        buttonStyleLabel.font = (UIFont(name: settings.font, size: font25))
        buttonStyleLabel.adjustsFontSizeToFitWidth = true
        buttonStyleLabel.textAlignment = .Center
        buttonStyleLabel.textColor = settings.textColor
        buttonStyleLabel.layer.backgroundColor = settings.textBackground.CGColor
        buttonStyleLabel.layer.borderColor = settings.textColor.CGColor
        buttonStyleLabel.layer.borderWidth = screenWidth * 0.006
        buttonStyleLabel.layer.cornerRadius = screenWidth * 0.04
        view.addSubview(buttonStyleLabel)
        
        //Button Style Button
        buttonStyleButton = UIButton(frame: CGRectMake(screenWidth * 0.6, screenHeight * 0.425, screenWidth * 0.35, screenHeight * 0.125))
        buttonStyleButton.setTitle("\(settings.buttonArray[settings.buttonColor]) and \(settings.backgroundArray[settings.backgroundColor])", forState: UIControlState.Normal)
        buttonStyleButton.titleLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        buttonStyleButton.titleLabel!.font = UIFont(name: settings.font, size: font25)
        buttonStyleButton.addTarget(self, action: "changeButtonStyle", forControlEvents: UIControlEvents.TouchUpInside)
        buttonStyleButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        view.addSubview(buttonStyleButton)
        
        //Currency Label
        currencyLabel = UILabel(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.625, screenWidth * 0.3, screenHeight * 0.07))
        currencyLabel.text = "Money:"
        currencyLabel.font = (UIFont(name: settings.font, size: font25))
        currencyLabel.adjustsFontSizeToFitWidth = true
        currencyLabel.textAlignment = .Center
        currencyLabel.textColor = settings.textColor
        currencyLabel.layer.backgroundColor = settings.textBackground.CGColor
        currencyLabel.layer.borderColor = settings.textColor.CGColor
        currencyLabel.layer.borderWidth = screenWidth * 0.006
        currencyLabel.layer.cornerRadius = screenWidth * 0.04
        view.addSubview(currencyLabel)
        
        //Currency Label 2
        currencyLabel2 = UILabel(frame: CGRectMake(screenWidth * 0.6, screenHeight * 0.625, screenWidth * 0.3, screenHeight * 0.07))
        currencyLabel2.text = "$\(settings.currency)"
        currencyLabel2.font = (UIFont(name: settings.font, size: font25))
        currencyLabel2.adjustsFontSizeToFitWidth = true
        currencyLabel2.textAlignment = .Center
        currencyLabel2.textColor = settings.textColor
        view.addSubview(currencyLabel2)
        
        //Reset Single Score Button
        resetSingleScore = UIButton(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.13, screenWidth * 0.4, screenHeight * 0.1))
        resetSingleScore.setTitle("Reset Score", forState: UIControlState.Normal)
        resetSingleScore.addTarget(self, action: "clearScore", forControlEvents: UIControlEvents.TouchUpInside)
        resetSingleScore.titleLabel!.font = UIFont(name: settings.font, size: font20)
        resetSingleScore.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        view.addSubview(resetSingleScore)
        
        //Reset All Scores Button
        resetAllScores = UIButton(frame: CGRectMake(screenWidth * 0.55, screenHeight * 0.13, screenWidth * 0.4, screenHeight * 0.1))
        resetAllScores.setTitle("Reset All", forState: UIControlState.Normal)
        resetAllScores.addTarget(self, action: "clearAll", forControlEvents: UIControlEvents.TouchUpInside)
        resetAllScores.titleLabel!.font = UIFont(name: settings.font, size: font20)
        resetAllScores.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        view.addSubview(resetAllScores)
        
        //Main Screen Button
        mainScreenButton = UIButton(frame: CGRectMake(screenWidth * 0.3, screenHeight * 0.75, screenWidth * 0.4, screenHeight * 0.1))
        mainScreenButton.setTitle("Return", forState: UIControlState.Normal)
        mainScreenButton.addTarget(self, action: "returnToGame", forControlEvents: UIControlEvents.TouchUpInside)
        mainScreenButton.titleLabel!.font = UIFont(name: settings.font, size: font25)
        mainScreenButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        view.addSubview(mainScreenButton)
        
        //Dev Button
        devButton = UIButton(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.8, screenWidth * 0.2, screenHeight * 0.1))
        devButton.addTarget(self, action: "moneyInDaBank", forControlEvents: UIControlEvents.TouchUpInside)
        devButton.titleLabel!.font = UIFont(name: settings.font, size: font25)
        devButton.backgroundColor = UIColor.yellowColor()
        view.addSubview(devButton)
        
        highScoreLabel2.text = "\(settings.highScores[settings.difficulty])"
        
        setColors()
    }
    
    func changeDifficulty()                                 //change difficulty
    {
        settings.difficulty = settings.difficulty + 1
        if(settings.difficulty > 3)
        {
            settings.difficulty = 0
        }
        highScoreLabel2.text = "\(settings.highScores[settings.difficulty])"
        difficultyButton.setTitle(difficultyArray[settings.difficulty], forState: UIControlState.Normal)
    }
    
    func clearScore()                                       //alert help
    {
        scoreCheck("One")
    }
    
    func clearAll()                                         //alert help
    {
        scoreCheck("All")
    }
    
    func resetOne()                                         //Reset current score
    {
        settings.highScores[settings.difficulty] = 0.0
        highScoreLabel2.text = "\(settings.highScores[settings.difficulty])"
        save()
    }
    
    func resetAll()                                         //Reset all scores
    {
        for index in 0...3
        {
            settings.highScores[index] = 0.0
        }
        save()
    }
    
    func scoreCheck(deleted: String)                        //Open Alert
    {
        let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .Alert)
        let alertAction1 = UIAlertAction(title: "Yes", style: .Destructive, handler: { (action: UIAlertAction!) in
            if(deleted == "One")                            //Identifier for which button was pressed
            {
                self.resetOne()
            }
            if(deleted == "All")
            {
                self.resetAll()
            }
        })
        let alertAction2 = UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
        })
        alert.addAction(alertAction1)
        alert.addAction(alertAction2)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func save()
    {
        settings.save()
    }
    
    func returnToGame()
    {
        save()
        performSegueWithIdentifier("toGameFromSettings", sender: self)
    }
    
    func changeButtonStyle()
    {
        save()
        performSegueWithIdentifier("toButtonChange", sender: self)
    }
    
    func setColors()
    {
        let bg = settings.determineBackground(settings.backgroundColor)
        var tc = settings.determineTextColor(settings.buttonColor)
        
        if((settings.buttonColor == settings.backgroundColor) && (!(settings.buttonColor == 0 && settings.backgroundColor == 0) && !(settings.buttonColor == 7 && settings.backgroundColor == 7)))      //Same Color
        {
            tc = UIColor.blackColor()
        }
        if(settings.buttonColor == 0 && settings.backgroundColor == 7)      //Same Color (black)
        {
            tc = UIColor.whiteColor()
        }
        if(settings.buttonColor == 7 && settings.backgroundColor == 0)      //Same Color (white)
        {
            tc = UIColor.blackColor()
        }
        
        originalContentView.backgroundColor = bg
        highScoreLabel.layer.backgroundColor = bg.CGColor
        highScoreLabel.layer.borderColor = tc.CGColor
        highScoreLabel.textColor = tc
        highScoreLabel2.textColor = tc
        difficultyLabel.layer.backgroundColor = bg.CGColor
        difficultyLabel.layer.borderColor = tc.CGColor
        difficultyLabel.textColor = tc
        buttonStyleLabel.layer.backgroundColor = bg.CGColor
        buttonStyleLabel.layer.borderColor = tc.CGColor
        buttonStyleLabel.textColor = tc
        currencyLabel.layer.backgroundColor = bg.CGColor
        currencyLabel.layer.borderColor = tc.CGColor
        currencyLabel.textColor = tc
        currencyLabel2.textColor = tc
        
        if(settings.backgroundColor == 1)   //Red (change button colors)
        {
            resetSingleScore.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            resetAllScores.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        }
        if(settings.backgroundColor == 2)   //Blue (change button colors)
        {
            difficultyButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            buttonStyleButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            mainScreenButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toGameFromSettings")
        {
            let dvc = segue.destinationViewController as! GameViewController
            dvc.settings = self.settings
        }
        if(segue.identifier == "toButtonChange")
        {
            let dvc = segue.destinationViewController as! ButtonViewController
            dvc.settings = self.settings
        }
    }
    
    func moneyInDaBank()    //Dev method
    {
        settings.currency += (300 + Int(arc4random_uniform(500)))
        currencyLabel2.text = "$\(settings.currency)"
    }
}
