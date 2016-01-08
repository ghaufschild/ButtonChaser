//
//  ButtonViewController.swift
//  Button Chaser
//
//  Created by Garrett Haufschild on 12/3/15.
//  Copyright © 2015 Swag Productions. All rights reserved.
//

import UIKit

class ButtonViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
    let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    
    var checkingOutButtons: Bool!
    
    var returnBack: UIButton!
    var buttonButton: UIButton!
    var backgroundButton: UIButton!
    var bigTitle: UILabel!
    var currencyLabel: UILabel!
    
    var rotationTimer = NSTimer()
    
    var collectionView: UICollectionView!
    
    var font25: CGFloat = 0.0
    
    var settings = Settings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canDisplayBannerAds = true
        checkingOutButtons = true
        
        font25 = screenWidth * 0.067
        
        //Title Label
        bigTitle = UILabel(frame: CGRect(x: screenWidth * 0.05, y: screenHeight * 0.03, width: screenWidth * 0.9, height: screenHeight * 0.07))
        bigTitle.text = "Change Button"
        bigTitle.textColor = UIColor.redColor()
        bigTitle.textAlignment = .Center
        bigTitle.layer.borderColor = settings.textColor.CGColor
        bigTitle.font = (UIFont(name: settings.font, size: font25))
        view.addSubview(bigTitle)
        
        //Currency Label
        currencyLabel = UILabel(frame: CGRect(x: screenWidth * 0.35, y: screenHeight * 0.8, width: screenWidth * 0.6, height: screenHeight * 0.1))
        currencyLabel.text = "Money: $\(settings.currency)"
        currencyLabel.textColor = UIColor.blackColor()
        currencyLabel.textAlignment = .Center
        currencyLabel.layer.borderColor = settings.textColor.CGColor
        currencyLabel.font = (UIFont(name: settings.font, size: font25))
        view.addSubview(currencyLabel)
        
        //Layout of Collection View
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenWidth * 0.8, height: screenHeight * 0.15)
        
        //Collection View
        collectionView = UICollectionView(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.18, screenWidth * 0.9, screenHeight * 0.6), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(BSCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.whiteColor()
        view.addSubview(collectionView)
        
        //Return Back Button
        returnBack = UIButton(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.8, screenWidth * 0.25, screenHeight * 0.1))
        returnBack.setTitle("Return", forState: UIControlState.Normal)
        returnBack.addTarget(self, action: "goToSettings", forControlEvents: UIControlEvents.TouchUpInside)
        returnBack.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        returnBack.titleLabel!.font = UIFont(name: settings.font, size: font25)
        view.addSubview(returnBack)
        
        //Button Button
        buttonButton = UIButton(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.1, screenWidth * 0.45, screenHeight * 0.05))
        buttonButton.setTitle("Buttons", forState: UIControlState.Normal)
        buttonButton.addTarget(self, action: "changeToButtons", forControlEvents: UIControlEvents.TouchUpInside)
        buttonButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        buttonButton.titleLabel!.font = UIFont(name: settings.font, size: font25)
        view.addSubview(buttonButton)
        
        //Background Button
        backgroundButton = UIButton(frame: CGRectMake(screenWidth * 0.45, screenHeight * 0.1, screenWidth * 0.45, screenHeight * 0.05))
        backgroundButton.setTitle("Backgrounds", forState: UIControlState.Normal)
        backgroundButton.addTarget(self, action: "changeToBackgrounds", forControlEvents: UIControlEvents.TouchUpInside)
        backgroundButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        backgroundButton.titleLabel!.font = UIFont(name: settings.font, size: font25)
        backgroundButton.alpha = 0.35
        view.addSubview(backgroundButton)
        
        rotationTimer = NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: Selector("updateCells"), userInfo: nil, repeats: true)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.buttonArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {                      //Set up Collection View
        if (checkingOutButtons == true)
        {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! BSCell
            
            //Overall Cell
            cell.backgroundColor = UIColor.whiteColor()
            cell.layer.borderColor = UIColor.blackColor().CGColor
            cell.layer.borderWidth = screenWidth * 0.008
            cell.layer.cornerRadius = screenWidth * 0.065
            
            //Text Label
            cell.textLabel.frame = CGRect(x: cell.buttonPreview.frame.width * 1.05, y: 0, width: cell.contentView.frame.width - cell.buttonPreview.frame.width * 1.1, height: cell.contentView.frame.height * 0.5)
            cell.textLabel.text = "\(settings.buttonArray[indexPath.row])"
            cell.textLabel.font = (UIFont(name: settings.font, size: font25))
            
            //Cost Label
            cell.costLabel.text = "Price: $\(Int(settings.buttonCost[indexPath.row]))"
            cell.costLabel.font = (UIFont(name: settings.font, size: font25))
            
            //Button Preview
            cell.buttonPreview.layer.cornerRadius = cell.buttonPreview.frame.width * 0.5
            cell.buttonPreview.layer.backgroundColor = settings.determineTextColor(indexPath.row).CGColor
            cell.buttonPreview.layer.borderColor = UIColor.blackColor().CGColor
            cell.buttonPreview.layer.borderWidth = screenWidth * 0.009
            
            if(indexPath.row == 0)                                  //Button is black
            {
                cell.buttonPreview.layer.borderColor = UIColor.whiteColor().CGColor
            }
            
            //Unlocked View
            if(settings.customButtons[indexPath.row] == false)      //Locked
            {
                cell.contentView.addSubview(cell.lockedView)
                cell.contentView.addSubview(cell.costLabel)
            }
            else                                                    //Unlocked
            {
                cell.textLabel.frame = CGRect(x: cell.buttonPreview.frame.width * 1.05, y: 0, width: cell.contentView.frame.width - cell.buttonPreview.frame.width * 1.1, height: cell.contentView.frame.height)
                cell.costLabel.removeFromSuperview()
                cell.lockedView.removeFromSuperview()
            }
            if(indexPath.row == settings.buttonColor)               //Selected
            {
                cell.backgroundColor = UIColor(red: 0, green: 100/255, blue: 0, alpha: 1.0)
            }
            return cell
        }
        else            //Looking at the backgrounds
        {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! BSCell
            //Overall Cell
            cell.backgroundColor = UIColor.whiteColor()
            cell.layer.borderColor = UIColor.blackColor().CGColor
            cell.layer.borderWidth = screenWidth * 0.008
            cell.layer.cornerRadius = screenWidth * 0.065
            
            //Text Label
            cell.textLabel.frame = CGRect(x: cell.buttonPreview.frame.width * 1.05, y: 0, width: cell.contentView.frame.width - cell.buttonPreview.frame.width * 1.1, height: cell.contentView.frame.height * 0.5)
            cell.textLabel.text = "\(settings.backgroundArray[indexPath.row])"
            cell.textLabel.font = (UIFont(name: settings.font, size: font25))
            
            //Cost Label
            cell.costLabel.text = "Price: $\(Int(settings.backgroundCost[indexPath.row]))"
            cell.costLabel.font = (UIFont(name: settings.font, size: font25))
            
            //Button Preview
            cell.buttonPreview.layer.cornerRadius = cell.buttonPreview.frame.width * 0.25
            cell.buttonPreview.layer.backgroundColor = settings.determineBackground(indexPath.row).CGColor
            cell.buttonPreview.layer.borderColor = UIColor.blackColor().CGColor
            cell.buttonPreview.layer.borderWidth = screenWidth * 0.009
            
            if(indexPath.row == 7)                              //White Border around Black Button
            {
                cell.buttonPreview.layer.borderColor = UIColor.whiteColor().CGColor
            }
            
            //Unlocked View
            if(settings.customBackgrounds[indexPath.row] == false)
            {
                cell.contentView.addSubview(cell.lockedView)
                cell.contentView.addSubview(cell.costLabel)
            }
            else
            {
                cell.textLabel.frame = CGRect(x: cell.buttonPreview.frame.width * 1.05, y: 0, width: cell.contentView.frame.width - cell.buttonPreview.frame.width * 1.1, height: cell.contentView.frame.height)
                cell.costLabel.removeFromSuperview()
                cell.lockedView.removeFromSuperview()
            }
            if(indexPath.row == settings.backgroundColor)
            {
                cell.backgroundColor = UIColor(red: 0, green: 100/255, blue: 0, alpha: 1.0)
            }
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if(checkingOutButtons == true)
        {
            if(settings.customButtons[indexPath.row] == true)       //sets to selected if unlocked
            {
                settings.buttonColor = indexPath.row
            }
            else
            {
                priceCheck(indexPath.row)                           //Present Alert View controller to purchase
            }
        }
        else        //Looking at backgrounds
        {
            if(settings.customBackgrounds[indexPath.row] == true)
            {
                settings.backgroundColor = indexPath.row
            }
            else
            {
                priceCheck(indexPath.row)                           //Present Alert View controller to purchase
            }
        }
        currencyLabel.text = "Money: $\(settings.currency)"
        settings.save()
        updateCells()
    }
    
    func priceCheck(cellNumber: Int)                               //Open Alert
    {
        let alert: UIAlertController!
        let alertAction1: UIAlertAction!
        let alertAction2: UIAlertAction!
        if(checkingOutButtons == true)                                          //Looking at buttons
        {
            if(settings.currency >= settings.buttonCost[cellNumber])            //Enough money for the button.
            {
                alert = UIAlertController(title: "You will be left with: $\(settings.currency - settings.buttonCost[cellNumber])", message: nil, preferredStyle: .Alert)
                alertAction1 = UIAlertAction(title: "Give it to me.", style: .Default, handler: { (action: UIAlertAction!) in
                    //Make it the active button
                    self.settings.buttonColor = cellNumber
                    self.settings.currency -= self.settings.buttonCost[cellNumber]
                    self.settings.customButtons[cellNumber] = true
                })
                alertAction2 = UIAlertAction(title: "Nevermind.", style: .Default, handler: { (action: UIAlertAction!) in
                })
                alert.addAction(alertAction1)
                alert.addAction(alertAction2)
            }
            else                                                                //Not enough moeny for the button
            {
                alert = UIAlertController(title: "You do not anough money. You need $\((settings.buttonCost[cellNumber] - settings.currency)) more.", message: nil, preferredStyle: .Alert)
                alertAction1 = UIAlertAction(title: "Okay", style: .Default, handler: { (action: UIAlertAction!) in
                })
                alert.addAction(alertAction1)
            }
        }
        else                                                                    //Looking at backgrounds
        {
            if(settings.currency >= settings.backgroundCost[cellNumber])            //Enough money for the button.
            {
                alert = UIAlertController(title: "You will be left with: $\(settings.currency - settings.backgroundCost[cellNumber])", message: nil, preferredStyle: .Alert)
                alertAction1 = UIAlertAction(title: "Give it to me.", style: .Default, handler: { (action: UIAlertAction!) in
                    //Make it the active background
                    self.settings.backgroundColor = cellNumber
                    self.settings.currency -= self.settings.backgroundCost[cellNumber]
                    self.settings.customBackgrounds[cellNumber] = true
                })
                alertAction2 = UIAlertAction(title: "Nevermind.", style: .Default, handler: { (action: UIAlertAction!) in
                })
                alert.addAction(alertAction1)
                alert.addAction(alertAction2)
            }
            else                                                                //Not enough moeny for the button
            {
                alert = UIAlertController(title: "You do not anough money. You need $\(settings.backgroundCost[cellNumber] - settings.currency) more.", message: nil, preferredStyle: .Alert)
                alertAction1 = UIAlertAction(title: "Okay", style: .Default, handler: { (action: UIAlertAction!) in
                })
                alert.addAction(alertAction1)
            }
        }
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func changeToButtons()
    {
        if(!checkingOutButtons == true)
        {
            bigTitle.text = "Change Button"
            backgroundButton.alpha = 0.35
            buttonButton.alpha = 1.0
            checkingOutButtons = true
            updateCells()
        }
    }
    
    func changeToBackgrounds()
    {
        if(checkingOutButtons == true)
        {
            bigTitle.text = "Change Background"
            buttonButton.alpha = 0.35
            backgroundButton.alpha = 1.0
            checkingOutButtons = false
            updateCells()
        }
    }
    
    func updateCells()
    {
        collectionView.reloadData()
    }
    
    func goToSettings()
    {
        performSegueWithIdentifier("toSettingsFromButton", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! SettingsViewController
        dvc.settings = self.settings
    }
}
