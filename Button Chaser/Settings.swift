//
//  Settings.swift
//  Button Chaser
//
//  Created by Garrett Haufschild on 11/23/15.
//  Copyright © 2015 Swag Productions. All rights reserved.
//

import UIKit

class Settings: NSObject, NSCoding {
    
    var customButtons: Array<Bool> = [true, false, false, false, false, false, false, false, false, false, false, false]    //Unlocked buttons
    var customBackgrounds: Array<Bool> = [true, false, false, false,false, false, false,false, false, false,false, false, false]    //Unlocked backgroudns
    var highScores: Array<Double> = [0.0, 0.0, 0.0, 0.0]    //Highscore from easy to insane
    var currency = 0                //Money
    var font = "EuphemiaUCAS"       //Current font
    var buttonColor: Int = 0        //Array index of selected button
    var backgroundColor: Int = 0    //Array index of selected background
    var difficulty: Int = 0         //Array index of selected difficulty
    var textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)            //Currently selected button color - used in SettingsViewController
    var textBackground = UIColor(red: 1, green: 1, blue: 1, alpha: 1)       //Currently selected background color - used in SettingsViewController
    var buttonArray: Array<String> = ["Black", "Red", "Blue", "Green", "Purple", "Orange", "Grey", "White", "Pink", "Light Blue", "Random", "Rainbow"]      //Array of button color names
    var backgroundArray: Array<String> = ["White", "Red", "Blue", "Green", "Purple", "Orange", "Grey", "Black", "Pink", "Light Blue", "Random", "Rainbow"]  //Array of background color names
    var buttonCost: Array<Int> = [0, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 5000, 5000]              //Array of button costs
    var backgroundCost: Array<Int> = [0, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 10000, 10000]        //Array of background costs
    var colorHue: CGFloat = 0.0     //Used for rainbow style in viewControllers with determineTextColor and determineBackgrorund methods below
    
    
    //NSCoding Stuff
    override init() {}
    
    required init(coder aDecoder: NSCoder) {
        self.customButtons = aDecoder.decodeObjectForKey("customButtons") as! Array<Bool>
        self.customBackgrounds = aDecoder.decodeObjectForKey("customBackgrounds") as! Array<Bool>
        self.highScores = aDecoder.decodeObjectForKey("highScores") as! Array<Double>
        self.currency = aDecoder.decodeIntegerForKey("currency")
        self.font = aDecoder.decodeObjectForKey("font") as! String
        self.buttonColor = aDecoder.decodeIntegerForKey("buttonColor")
        self.backgroundColor = aDecoder.decodeIntegerForKey("backgroundColor")
        self.difficulty = aDecoder.decodeIntegerForKey("difficulty")
        self.textColor = aDecoder.decodeObjectForKey("textColor") as! UIColor
        self.textBackground = aDecoder.decodeObjectForKey("textBackground") as! UIColor
    }
   
    func encodeWithCoder(coder: NSCoder)
    {
        coder.encodeObject(self.customButtons, forKey: "customButtons")
        coder.encodeObject(self.customBackgrounds, forKey: "customBackgrounds")
        coder.encodeObject(self.highScores, forKey: "highScores")
        coder.encodeInteger(self.currency, forKey: "currency")
        coder.encodeObject(self.font, forKey: "font")
        coder.encodeInteger(self.buttonColor, forKey: "buttonColor")
        coder.encodeInteger(self.backgroundColor, forKey: "backgroundColor")
        coder.encodeInteger(self.difficulty, forKey: "difficulty")
        coder.encodeObject(self.textColor, forKey: "textColor")
        coder.encodeObject(self.textBackground, forKey: "textBackground")
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "settings")
    }
    
    class func loadSaved() -> Settings? {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("settings") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Settings
        }
        return nil
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("settings")
    }
    
    //End of NSCoding Stuff
    
    func determineTextColor(index: Int) -> UIColor      //Used in view controllers to help make colors universal
    {
        if(index == 1)
        {
            return UIColor.redColor()
        }
        if(index == 2)
        {
            return UIColor.blueColor()
        }
        if(index == 3)
        {
            return UIColor.greenColor()
        }
        if(index == 4)
        {
            return UIColor.purpleColor()
        }
        if(index == 5)
        {
            return UIColor.orangeColor()
        }
        if(index == 6)
        {
            return UIColor.grayColor()
        }
        if(index == 7)
        {
            return UIColor.whiteColor()
        }
        if(index == 8)      //Pink
        {
            return UIColor(red: 1, green: 150/255, blue: 150/255, alpha: 1)
        }
        if(index == 9)      //Light Blue
        {
            return UIColor(red: 0, green: 1, blue: 1, alpha: 1)
        }
        if(index == 10)     //Random
        {
            return UIColor(red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1)
        }
        if(index == 11)     //Rainbow
        {
            colorHue = colorHue + (1.0/35.0)
            if(colorHue >= 5.0/35.0 && colorHue <= 8.0/35.0)
            {
                colorHue = 8.0/35.0
            }
            if (colorHue >= 1.0)
            {
                colorHue = colorHue - 1
            }
            return UIColor(hue: colorHue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        return UIColor.blackColor()
    }
    
    func determineBackground(index: Int) -> UIColor     //Used in view controllers to help make colors universal
    {
        if(index == 1)
        {
            return UIColor.redColor()
        }
        if(index == 2)
        {
            return UIColor.blueColor()
        }
        if(index == 3)
        {
            return UIColor.greenColor()
        }
        if(index == 4)
        {
            return UIColor.purpleColor()
        }
        if(index == 5)
        {
            return UIColor.orangeColor()
        }
        if(index == 6)
        {
            return UIColor.grayColor()
        }
        if(index == 7)
        {
            return UIColor.blackColor()
        }
        if(index == 8)
        {
            return UIColor(red: 1, green: 150/255, blue: 150/255, alpha: 1)
        }
        if(index == 9)
        {
            return UIColor(red: 0, green: 1, blue: 1, alpha: 1)
        }
        if(index == 10)
        {
            return UIColor(red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1)
        }
        if(index == 11)
        {
            colorHue = colorHue + (1.0/35.0)
            if(colorHue >= 5.0/35.0 && colorHue <= 8.0/35.0)
            {
                colorHue = 8.0/35.0
            }
            if (colorHue >= 1.0)
            {
                colorHue = colorHue - 1
            }
            return UIColor(hue: colorHue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        return UIColor.whiteColor()
    }
}
