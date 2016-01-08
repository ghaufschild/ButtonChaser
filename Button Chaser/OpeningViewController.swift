//
//  OpeningViewController.swift
//  Button Chaser
//
//  Created by Garrett Haufschild on 11/23/15.
//  Copyright © 2015 Swag Productions. All rights reserved.
//

import UIKit

class OpeningViewController: UIViewController {

    let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
    let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    
    var gameButton: UIButton!
    var settingsButton: UIButton!
    var gameLabel: UILabel!
    var currencyLabel: UILabel!
    
    var font25: CGFloat = 0
    var font35: CGFloat = 0
    var font45: CGFloat = 0
    
    var settings = Settings()
    
    var resetGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        font25 = screenWidth * 0.067
        font35 = screenWidth * 0.093
        font45 = screenWidth * 0.12
        
        if let settings = Settings.loadSaved()
        {
            self.settings = settings
        } else
        {
            let settings: Settings = Settings()
            settings.save()
            self.settings = settings
        }

        //View
        view.backgroundColor = settings.textBackground
        
        //Game Label
        gameLabel = UILabel(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.1, screenWidth * 0.9, screenHeight * 0.285))
        gameLabel.text = "Welcome to\nButton Chaser"
        gameLabel.numberOfLines = 3
        gameLabel.font = (UIFont(name: settings.font, size: font45))
        gameLabel.adjustsFontSizeToFitWidth = true
        gameLabel.textAlignment = .Center
        gameLabel.textColor = settings.textColor
        gameLabel.layer.backgroundColor = settings.textBackground.CGColor
        gameLabel.layer.borderColor = settings.textColor.CGColor
        gameLabel.layer.borderWidth = screenWidth * 0.012
        gameLabel.layer.cornerRadius = screenWidth * 0.15
        view.addSubview(gameLabel)
        
        //Game Button
        gameButton = UIButton(frame: CGRectMake(screenWidth * 0.3, screenHeight * 0.475, screenWidth * 0.4, screenHeight * 0.1))
        gameButton.setTitle("PLAY", forState: UIControlState.Normal)
        gameButton.titleLabel!.font = UIFont(name: settings.font, size: font35)
        gameButton.addTarget(self, action: "goToGame", forControlEvents: UIControlEvents.TouchUpInside)
        gameButton.setTitleColor(settings.textColor, forState: UIControlState.Normal)
        gameButton.backgroundColor = settings.textBackground
        gameButton.layer.borderColor = settings.textColor.CGColor
        gameButton.layer.borderWidth = screenWidth * 0.01
        gameButton.layer.cornerRadius = screenWidth * 0.07
        view.addSubview(gameButton)
        
        //Settings Button
        settingsButton = UIButton(frame: CGRectMake(screenWidth * 0.2, screenHeight * 0.65, screenWidth * 0.6, screenHeight * 0.1))
        settingsButton.setTitle("SETTINGS", forState: UIControlState.Normal)
        settingsButton.titleLabel!.font = UIFont(name: settings.font, size: font35)
        settingsButton.addTarget(self, action: "goToSettings", forControlEvents: UIControlEvents.TouchUpInside)
        settingsButton.setTitleColor(settings.textColor, forState: UIControlState.Normal)
        settingsButton.backgroundColor = settings.textBackground
        settingsButton.layer.borderColor = settings.textColor.CGColor
        settingsButton.layer.borderWidth = screenWidth * 0.01
        settingsButton.layer.cornerRadius = screenWidth * 0.07
        view.addSubview(settingsButton)
        
        //Currency Label
        currencyLabel = UILabel(frame: CGRectMake(screenWidth * 0.4, screenHeight * 0.85, screenWidth * 0.55, screenHeight * 0.07))
        let niceMoney = round(settings.currency)
        currencyLabel.text = "Money: $\(niceMoney)"
        currencyLabel.font = (UIFont(name: settings.font, size: font25))
        currencyLabel.textAlignment = .Center
        currencyLabel.textColor = settings.textColor
        //currencyLabel.layer.backgroundColor = settings.textBackground.CGColor
        //currencyLabel.layer.borderColor = settings.textColor.CGColor
        //currencyLabel.layer.borderWidth = screenWidth * 0.008
        //currencyLabel.layer.cornerRadius = screenWidth * 0.04
        view.addSubview(currencyLabel)
        
        //Reset Game Button
        resetGameButton = UIButton(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.9, screenWidth * 0.4, screenHeight * 0.07))
        resetGameButton.setTitle("Reset Game", forState: UIControlState.Normal)
        resetGameButton.titleLabel!.font = UIFont(name: settings.font, size: font25)
        resetGameButton.addTarget(self, action: "resetGame", forControlEvents: UIControlEvents.TouchUpInside)
        resetGameButton.setTitleColor(settings.textColor, forState: UIControlState.Normal)
        resetGameButton.backgroundColor = settings.textBackground
        resetGameButton.layer.borderColor = settings.textColor.CGColor
        resetGameButton.layer.borderWidth = screenWidth * 0.01
        resetGameButton.layer.cornerRadius = screenWidth * 0.07
        view.addSubview(resetGameButton)
        
        setColors()
    }
    
    func setColors()
    {
        let bg = settings.determineBackground(settings.backgroundColor)
        var tc = settings.determineTextColor(settings.buttonColor)
        
        if((settings.buttonColor == settings.backgroundColor) && (!(settings.buttonColor == 0 && settings.backgroundColor == 0) && !(settings.buttonColor == 7 && settings.backgroundColor == 7)))
        {
            tc = UIColor.blackColor()
        }
        if(settings.buttonColor == 0 && settings.backgroundColor == 7)
        {
            tc = UIColor.whiteColor()
        }
        if(settings.buttonColor == 7 && settings.backgroundColor == 0)
        {
            tc = UIColor.blackColor()
        }
        
        view.backgroundColor = bg
        gameLabel.layer.backgroundColor = bg.CGColor
        gameLabel.layer.borderColor = tc.CGColor
        gameLabel.textColor = tc
        gameButton.layer.backgroundColor = bg.CGColor
        gameButton.layer.borderColor = tc.CGColor
        gameButton.setTitleColor(tc, forState: UIControlState.Normal)
        settingsButton.layer.backgroundColor = bg.CGColor
        settingsButton.layer.borderColor = tc.CGColor
        settingsButton.setTitleColor(tc, forState: UIControlState.Normal)
        currencyLabel.textColor = tc
    }
    
    func resetGame()
    {
        settings.clear()
    }
    
    func goToSettings()
    {
        performSegueWithIdentifier("toSettings", sender: self)
    }
    
    func goToGame()
    {
        performSegueWithIdentifier("toGame", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "toSettings")
        {
            let dvc = segue.destinationViewController as! SettingsViewController
            dvc.settings = self.settings
        }
        else
        {
            let dvc = segue.destinationViewController as! GameViewController
            dvc.settings = self.settings
        }
    }
}
